#!/bin/bash

echo "Starting Docker containers..."
docker-compose up -d

if [ $? -eq 0 ]; then
    echo "The Docker containers have been successfully started."

    echo "You can use the following URLs for your application:
  https://admin.myapp.local (administration interface)
  https://back.myapp.local (backend server)
  https://front.myapp.local (portfolio website)"
echo "For convenience, you can add the following aliases to your ~/.bashrc file:
  alias goportfolio='cd ~/your-project-dir'
  alias startportfolio='cd ~/your-project-dir && bash bin/start_container.sh'
  alias restartportfolio='cd ~/your-project-dir && bash bin/restart_container.sh'
  alias stopportfolio='cd ~/your-project-dir && bash bin/stop_container.sh'
  alias logsportfolio='cd ~/your-project-dir && bash bin/show_logs.sh'"
else
    echo "An error occurred while starting the Docker containers."
    exit 1
fi

echo "To check the logs, use the command: docker-compose logs -f."
