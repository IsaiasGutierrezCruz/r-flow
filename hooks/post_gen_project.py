#!/usr/bin/env python3
"""
Post-generation hook script for {{ cookiecutter.project_name }}
This script runs after the cookiecutter template is generated.
"""

import os
import subprocess
import sys
from pathlib import Path

def run_command(cmd, cwd=None):
    """Run a command and return the result."""
    try:
        result = subprocess.run(
            cmd, 
            shell=True, 
            check=True, 
            capture_output=True, 
            text=True,
            cwd=cwd
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Error running command '{cmd}': {e}")
        return None

def initialize_git():
    """Initialize git repository if requested."""
    if "{{ cookiecutter.use_git }}" == "y":
        print("🔧 Initializing git repository...")
        if run_command("git init"):
            print("✅ Git repository initialized")
            
            # Add all files to git
            run_command("git add .")
            
            # Make initial commit
            commit_message = "Initial commit from {{ cookiecutter.project_name }} template"
            if run_command(f'git commit -m "{commit_message}"'):
                print("✅ Initial commit created")
            
            # Set up GitHub remote if requested
            if "{{ cookiecutter.use_github }}" == "y":
                github_url = f"https://github.com/{{ cookiecutter.github_username }}/{{ cookiecutter.project_slug }}.git"
                if run_command(f"git remote add origin {github_url}"):
                    print(f"✅ GitHub remote added: {github_url}")
                    print("📝 Note: Remember to create the repository on GitHub and push your changes")
        else:
            print("❌ Failed to initialize git repository")

def create_license():
    """Create license file if requested."""
    license_type = "{{ cookiecutter.license }}"
    if license_type != "None":
        print(f"📄 Creating {license_type} license file...")
        
        license_templates = {
            "MIT": """MIT License

Copyright (c) {{ cookiecutter.year }} {{ cookiecutter.author_name }}

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
""",
            "GPL-3": """GNU GENERAL PUBLIC LICENSE
Version 3, 29 June 2007

Copyright (C) {{ cookiecutter.year }} {{ cookiecutter.author_name }}

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
""",
            "Apache-2.0": """Apache License
Version 2.0, January 2004
http://www.apache.org/licenses/

Copyright {{ cookiecutter.year }} {{ cookiecutter.author_name }}

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
""",
            "BSD-3-Clause": """BSD 3-Clause License

Copyright (c) {{ cookiecutter.year }}, {{ cookiecutter.author_name }}

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"""
        }
        
        if license_type in license_templates:
            with open("LICENSE", "w") as f:
                f.write(license_templates[license_type])
            print(f"✅ {license_type} license file created")

def print_next_steps():
    """Print next steps for the user."""
    print("\n" + "="*60)
    print("🎉 {{ cookiecutter.project_name }} project created successfully!")
    print("="*60)
    print("\n📋 Next steps:")
    print("1. Navigate to your project directory:")
    print("   cd {{ cookiecutter.project_slug }}")
    print("\n2. Build and start the development environment:")
    print("   make build")
    print("   make up")
    print("\n3. Access RStudio Server:")
    print("   Open http://localhost:8787 in your browser")
    print("   Username: rstudio")
    print("   Password: {{ cookiecutter.rstudio_server_password }}")
    print("\n4. Initialize renv (first time only):")
    print("   make renv-init")
    print("\n5. For VS Code development:")
    print("   - Install the 'Remote - Containers' extension")
    print("   - Open the project in VS Code")
    print("   - Click 'Reopen in Container'")
    print("\n📚 Documentation:")
    print("   - README.md: Complete project documentation")
    print("   - make help: Show available commands")
    print("   - docs/: Project documentation and examples")
    print("\n🔧 Useful commands:")
    print("   - make help: Show all available commands")
    print("   - make r-console: Open R console")
    print("   - make lint: Check code quality")
    print("   - make test: Run unit tests")
    
    if "{{ cookiecutter.use_github }}" == "y":
        print("\n🔗 GitHub setup:")
        print("   1. Create a repository on GitHub:")
        print("      https://github.com/{{ cookiecutter.github_username }}/{{ cookiecutter.project_slug }}")
        print("   2. Push your changes:")
        print("      git push -u origin main")
    
    print("\n✨ Happy coding!")
    print("="*60)

def main():
    """Main function to run post-generation tasks."""
    print("🚀 Setting up {{ cookiecutter.project_name }}...")
    
    # Initialize git if requested
    initialize_git()
    
    # Create license file if requested
    create_license()
    
    # Print next steps
    print_next_steps()

if __name__ == "__main__":
    main() 