#!bin/bash
docker_inst() {
  sudo apt update -y
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  sudo apt update -y
  sudo apt install docker-ce -y
  sudo usermod -aG docker ${USER}
  sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}
run_task() {
  cd /tmp/task1
  sudo docker-compose up -d
}

############################## MAIN ##############################
docker_inst
run_task
