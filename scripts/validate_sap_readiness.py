#!/usr/bin/env python3
"""
validate_sap_readiness.py
-------------------------
Checks basic SAP HANA system prerequisites:
- OS type and version
- CPU cores
- RAM
- Disk space
- Key ports (e.g., HANA SQL port)
"""

import os
import platform
import shutil
import psutil  
import socket

# --------------------------
# Check OS
# --------------------------
def check_os():
    os_info = platform.system() + " " + platform.release()
    print(f"[OS] {os_info}")
    return os_info

# --------------------------
# Check CPU cores
# --------------------------
def check_cpu(min_cores=4):
    cores = psutil.cpu_count(logical=False)
    print(f"[CPU] {cores} physical cores detected")
    return cores >= min_cores

# --------------------------
# Check RAM
# --------------------------
def check_memory(min_gb=16):
    mem_gb = round(psutil.virtual_memory().total / (1024**3))
    print(f"[Memory] {mem_gb} GB detected")
    return mem_gb >= min_gb

# --------------------------
# Check disk space
# --------------------------
def check_disk(min_gb=100, path="/"):
    free_gb = round(shutil.disk_usage(path).free / (1024**3))
    print(f"[Disk] {free_gb} GB free at {path}")
    return free_gb >= min_gb

# --------------------------
# Check network port
# --------------------------
def check_port(port):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        result = s.connect_ex(('localhost', port))
        available = result != 0
    print(f"[Port {port}] {'Available' if available else 'In Use'}")
    return available

# --------------------------
# Main function
# --------------------------
def main():
    print("=== SAP HANA Readiness Check ===\n")

    all_ok = True
    all_ok &= check_cpu()
    all_ok &= check_memory()
    all_ok &= check_disk()
    all_ok &= check_port(30015)  # example SAP HANA SQL port

    print("\n=== Summary ===")
    if all_ok:
        print("✅ Environment looks ready for SAP HANA!")
    else:
        print("❌ Some requirements are not met. Review above logs.")

# --------------------------
# Run main
# --------------------------
if __name__ == "__main__":
    main()
