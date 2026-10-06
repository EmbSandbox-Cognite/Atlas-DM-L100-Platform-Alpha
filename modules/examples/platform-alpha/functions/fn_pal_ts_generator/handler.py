"""CDF Function: deterministic time series backfill/append for Platform Alpha."""
from __future__ import annotations

from datetime import datetime, timedelta, timezone

from cognite.client import CogniteClient
from cognite.client.data_classes.data_modeling import NodeId

from profiles import SERIES_IDS, TS_START, value_at

INSTANCE_SPACE = "sp_pal_instances"
STEP = timedelta(minutes=10)
UTC = timezone.utc


def _floor_10min(ts: datetime) -> datetime:
    ts = ts.astimezone(UTC).replace(second=0, microsecond=0)
    return ts - timedelta(minutes=ts.minute % 10)


def handle(client: CogniteClient, data: dict | None = None) -> dict:
    now = _floor_10min(datetime.now(tz=UTC))
    written = 0
    per_series: dict[str, int] = {}

    for series_id in SERIES_IDS:
        instance_id = NodeId(INSTANCE_SPACE, series_id)
        latest = client.time_series.data.retrieve_latest(instance_id=instance_id)
        if latest and latest.timestamp:
            start = latest.timestamp.astimezone(UTC) + STEP
        else:
            start = TS_START

        if start > now:
            per_series[series_id] = 0
            continue

        timestamps: list[int] = []
        values: list[float] = []
        t = start
        while t <= now:
            timestamps.append(int(t.timestamp() * 1000))
            values.append(float(value_at(series_id, t)))
            t += STEP

        if not timestamps:
            per_series[series_id] = 0
            continue

        # Batch insert
        batch = 50000
        for i in range(0, len(timestamps), batch):
            client.time_series.data.insert(
                instance_id=instance_id,
                datapoints=list(zip(timestamps[i : i + batch], values[i : i + batch], strict=True)),
            )
        per_series[series_id] = len(timestamps)
        written += len(timestamps)

    return {
        "success": True,
        "datapoints_written": written,
        "per_series": per_series,
        "end": now.isoformat(),
    }
