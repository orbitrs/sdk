#!/usr/bin/env python3
"""
Orbit Framework Development Task Runner
Optimized for rapid development and continuous iteration
"""

import subprocess
import sys
import time
import os
from pathlib import Path
import argparse

class TaskRunner:
    def __init__(self):
        self.start_time = time.time()
        
    def log(self, message, level="INFO"):
        timestamp = time.strftime("%H:%M:%S")
        colors = {
            "INFO": "\033[36m",    # Cyan
            "SUCCESS": "\033[32m", # Green
            "ERROR": "\033[31m",   # Red
            "WARNING": "\033[33m"  # Yellow
        }
        reset = "\033[0m"
        print(f"{colors.get(level, '')}{timestamp} [{level}] {message}{reset}")
    
    def run_command(self, cmd, description=""):
        """Run a command with timing and error handling"""
        if description:
            self.log(f"Starting: {description}")
        
        start = time.time()
        try:
            result = subprocess.run(cmd, shell=True, check=True, 
                                  capture_output=True, text=True)
            duration = time.time() - start
            self.log(f"✅ {description} completed in {duration:.2f}s", "SUCCESS")
            return result
        except subprocess.CalledProcessError as e:
            duration = time.time() - start
            self.log(f"❌ {description} failed in {duration:.2f}s", "ERROR")
            self.log(f"Error: {e.stderr}", "ERROR")
            return None
    
    def fast_check(self):
        """Quick workspace validation"""
        return self.run_command("cargo check --workspace", "Fast workspace check")
    
    def test_suite(self):
        """Run comprehensive test suite"""
        return self.run_command("cargo test --workspace", "Test suite")
    
    def build_all(self):
        """Build all workspace crates"""
        return self.run_command("cargo build --workspace", "Build all crates")
    
    def dev_server(self):
        """Start development server with hot reload"""
        self.log("Starting development server with hot reload...")
        return self.run_command("cargo watch -x 'run --bin orbiton -- dev'", 
                               "Development server")
    
    def format_code(self):
        """Format all code"""
        return self.run_command("cargo fmt --all", "Code formatting")
    
    def lint_code(self):
        """Run clippy linting"""
        return self.run_command("cargo clippy --workspace --all-targets -- -D warnings", 
                               "Code linting")
    
    def rapid_iteration(self):
        """Complete rapid development cycle"""
        tasks = [
            ("Format", self.format_code),
            ("Check", self.fast_check),
            ("Lint", self.lint_code),
            ("Test", self.test_suite),
            ("Build", self.build_all)
        ]
        
        self.log("🚀 Starting rapid iteration cycle", "INFO")
        total_start = time.time()
        
        for name, task in tasks:
            if not task():
                self.log(f"❌ Rapid iteration failed at: {name}", "ERROR")
                return False
        
        total_time = time.time() - total_start
        self.log(f"🎉 Rapid iteration completed in {total_time:.2f}s", "SUCCESS")
        return True

def main():
    parser = argparse.ArgumentParser(description="Orbit Framework Development Tasks")
    parser.add_argument("task", choices=[
        "check", "test", "build", "dev", "format", "lint", "rapid"
    ], help="Task to run")
    
    args = parser.parse_args()
    runner = TaskRunner()
    
    tasks = {
        "check": runner.fast_check,
        "test": runner.test_suite,
        "build": runner.build_all,
        "dev": runner.dev_server,
        "format": runner.format_code,
        "lint": runner.lint_code,
        "rapid": runner.rapid_iteration
    }
    
    success = tasks[args.task]()
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
