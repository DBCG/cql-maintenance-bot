# cql-maintenance-bot

Scripts to automatically run project maintenance. This project just checks out the various cql-based projects that Alphora/DCG maintains and run scripts to update them. It opens PRs if it discovers changes.

## Usage

Install the `hub` command-line tool (`sudo apt-get -y install hub`)

Set the `GITHUB_EMAIL`, `GITHUB_USER`, and `GITHUB_TOKEN` environment variables appropriately.

Run the ```build.sh``` script

## License

Copyright 2019+ Dynamic Content Group, LLC (dba Alphora)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
