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
        assert config["model"] == {
            "provider": "openai-api",
            "default": "openai-codex/pods/gpt-5.5",
            "base_url": "http://workpods-llm-gateway:8080/v1",
            "api_mode": "codex_responses",
        }, path
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
    assert ".runtime/secrets/hermes-pods/llm-gateway.env" in compose
    assert "CODEX_HOME" not in compose

    dockerfile = (PODS / "Dockerfile.hermes-codex").read_text(encoding="utf-8")
    assert "@openai/codex" not in dockerfile
    assert "codex --version" not in dockerfile

    gateway_env = (PODS / "env/llm-gateway.env.example").read_text(encoding="utf-8")
    assert "OPENAI_API_KEY=REPLACE_WITH_HERMES_GATEWAY_TOKEN" in gateway_env
    assert "OPENAI_BASE_URL=http://workpods-llm-gateway:8080/v1" in gateway_env

    predeploy = (PODS / "scripts/predeploy").read_text(encoding="utf-8")
    assert "OPENAI_BASE_URL" in predeploy
    assert "direct provider auth must be archived" in predeploy
    assert not (PODS / "scripts/seed-codex-auth").exists()


if __name__ == "__main__":
    main()
