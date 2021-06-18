curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.12.1-linux-x86_64.tar.gz
tar xzvf metricbeat-7.12.1-linux-x86_64.tar.gz
./metricbeat-7.12.1-linux-x86_64/metricbeat modules enable system
./metricbeat-7.12.1-linux-x86_64/metricbeat setup -e
./metricbeat-7.12.1-linux-x86_64/metricbeat -e


