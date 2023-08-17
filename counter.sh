(
echo 'Acquire::http::Proxy "http://face452k.bit-tech.co:8105";'|sudo tee /etc/apt/apt.conf.d/00aptproxy
sudo cp /home/detect/sources.list.bak /etc/apt/sources.list
sudo cp /home/detect/unlift-plugin.py /etc/unlift_plugins/
sudo chmod 755 /etc/unlift_plugins/unlift-plugin.py
sudo cp /home/detect/sources.list /etc/apt/;sudo sed -i 's/xenial/bionic/g' /etc/apt/sources.list
sudo apt update
sudo apt install -y findface-counter
sudo apt install -y postgresql-10 redis-server pgbouncer
echo '"ntech" "9T3g1nXy9yx3y8MIGm9fbef3dia8UTc3"' | sudo tee -a /etc/pgbouncer/userlist.txt

sudo sed -i 's/\[databases\]/\[databases\]\nffsecurity = dbname=ffsecurity host=localhost port=5432 user=ntech\nauth_type = plain\npool_mode = transaction\nmax_client_conn = 16384\nsyslog = 1\nlisten_port = 5439\n/' /etc/pgbouncer/pgbouncer.ini

sudo systemctl enable postgresql@10-main.service redis-server etcd.service memcached.service pgbouncer.service
sudo systemctl start postgresql@10-main.service redis-server etcd.service memcached.service pgbouncer.service
echo "
CREATE ROLE ntech WITH LOGIN PASSWORD '9T3g1nXy9yx3y8MIGm9fbef3dia8UTc3';
CREATE DATABASE ffsecurity WITH OWNER ntech ENCODING 'UTF-8' LC_COLLATE='en_US.UTF-8' LC_CTYPE='en_US.UTF-8' TEMPLATE template0;
CREATE DATABASE ffcounter WITH OWNER ntech ENCODING 'UTF-8' LC_COLLATE='C.UTF-8' LC_CTYPE='C.UTF-8' TEMPLATE template0;"|sudo -u postgres psql

echo 'local all ntech peer' | sudo tee -a /etc/postgresql/10/main/pg_hba.conf
sudo systemctl restart postgresql@10-main.service
sudo systemctl restart findface-counter
sudo systemctl enable findface-counter
sudo systemctl restart unlift
)
