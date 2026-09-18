#!/usr/bin/env python3
"""Validate basic SAP HANA host readiness requirements."""

from __future__ import annotations

import platform
import shutil
import socket
import sys

import psutil


def check_os() -> bool:
    os_info = f"{platform.system()} {platform.release()}"
    print(f"[OS] {os_info}")
    return True


def check_cpu(min_cores: int = 4) -> bool:
    cores = psutil.cpu_count(logical=False) or 0
    print(f"[CPU] {cores} physical cores detected")
    return cores >= min_cores


def check_memory(min_gb: int = 16) -> bool:
    mem_gb = round(psutil.virtual_memory().total / (1024**3))
    print(f"[Memory] {mem_gb} GB detected")
    return mem_gb >= min_gb


def check_disk(min_gb: int = 100, path: str = "/") -> bool:
    free_gb = round(shutil.disk_usage(path).free / (1024**3))
    print(f"[Disk] {free_gb} GB free at {path}")
    return free_gb >= min_gb


def check_port_available(port: int) -> bool:
    """Check whether the example HANA SQL port is available."""
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        result = sock.connect_ex(("localhost", port))

    available = result != 0
    print(
        f"[Port {port}] "
        f"{'Available' if available else 'Already in use'}"
    )
    return available


def main() -> int:
    print("=== SAP HANA Host Readiness Check ===\n")

    checks = {
        "OS": check_os(),
        "CPU": check_cpu(),
        "Memory": check_memory(),
        "Disk": check_disk(),
        "HANA SQL port": check_port_available(30015),
    }

    print("\n=== Summary ===")

    failed = [name for name, passed in checks.items() if not passed]

    if failed:
        print("Readiness checks failed:")
        for name in failed:
            print(f"  - {name}")
        return 1

    print("Environment meets the configured readiness thresholds.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
