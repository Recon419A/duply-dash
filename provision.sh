#! /bin/sh

echo I am provisioning...
date > /etc/vagrant_provisioned_at
apt-get update && apt-get install -y python-pip duply gcc python-dev

## Generate mock data for duply
for mockdir in foo bar baz foo-bar ; do
    mkdir -p /etc/duply/${mockdir} &&
    sudo cp /vagrant/duply-conf /etc/duply/${mockdir}/conf &&
    echo "TARGET='file:///tmp/duply/${mockdir}'" >> /etc/duply/${mockdir}/conf &&
    sudo cp /vagrant/duply-exclude /etc/duply/${mockdir}/exclude;
done

if [ -f /vagrant/custom_ca.crt ]; then
    sudo cp /vagrant/custom_ca.crt /usr/local/share/ca-certificates/ && sudo update-ca-certificates;
fi

cd /vagrant && pip install -r requirements.txt
