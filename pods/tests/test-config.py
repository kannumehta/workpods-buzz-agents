#!/usr/bin/env python3
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[2]
PODS = ROOT / "pods"
CONFIGS = [
    PODS / "config/internal-workpods/config.yaml",
    PODS / "config/internal-workpods/profile-configs/internal-buzz-pod.yaml",
    PODS / "config/marketing-pod/config.yaml",
    PODS / "config/support-desk-pod/config.yaml",
]


def main() -> None:
    for path in CONFIGS:
        config = yaml.safe_load(path.read_text(encoding="utf-8"))
        assert config["agent"]["disabled_toolsets"] == ["skills"], path
        assert config["curator"]["enabled"] is False, path
        assert config["kanban"]["dispatch_in_gateway"] is False, path
        buzz = config.get("gateway", {}).get("platforms", {}).get("buzz")
        if buzz:
            assert buzz["extra"]["transport"] == "websocket", path

    manifest = []
    for line in (PODS / "config/manifest.tsv").read_text(encoding="utf-8").splitlines():
        if line and not line.startswith("#"):
            fields = line.split("\t")
            assert len(fields) == 5, line
            manifest.append(fields)
    assert len(manifest) == 22
    assert sum(row[1] == "marker" for row in manifest) == 7
    assert len({(row[0], row[4]) for row in manifest}) == len(manifest)

    tracked = list((PODS / "config").rglob("*"))
    assert not any(path.name == "USER.md" for path in tracked)
    assert not any(path.name == "SKILL.md" for path in tracked)

    compose = (PODS / "compose.pods.yml").read_text(encoding="utf-8")
    assert "HERMES_DASHBOARD" not in compose
    assert "9119" not in compose
    assert "email-management" not in compose
    assert "WORKPODS_BUILD_REVISION:?" in compose


if __name__ == "__main__":
    main()
