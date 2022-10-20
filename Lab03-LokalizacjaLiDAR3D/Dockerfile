################################################################################
# IMPORTANT!!! It will set correct ownership of files, so they can be modified #
# from host:                                                                   #
#$ docker build -t myimage \                                                   #
#  --build-arg USER_ID=$(id -u) \                                              #
#  --build-arg GROUP_ID=$(id -g) .                                             #
################################################################################
FROM osrf/ros:noetic-desktop-full

ARG USER_ID
ARG GROUP_ID

RUN echo "source /opt/ros/noetic/setup.bash" >> /etc/bash.bashrc

# Hush debconf(Debian package configuration system) complaints and interactive prompt
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y \
    vim \
    mesa-utils \
    ros-noetic-rviz \
    git

RUN apt-get -y install \
    ros-noetic-desktop-full \
    ros-noetic-rqt-* \
    ros-noetic-joy \
    ros-noetic-teleop-twist-joy \
    ros-noetic-teleop-twist-keyboard \
    ros-noetic-laser-proc \
    ros-noetic-rgbd-launch \
    ros-noetic-depthimage-to-laserscan \
    ros-noetic-rosserial-arduino \
    ros-noetic-rosserial-python \
    ros-noetic-rosserial-server \
    ros-noetic-rosserial-client \
    ros-noetic-rosserial-msgs \
    ros-noetic-amcl \
    ros-noetic-map-server \
    ros-noetic-move-base \
    ros-noetic-urdf \
    ros-noetic-xacro \
    ros-noetic-compressed-image-transport \
    ros-noetic-rqt-image-view \
    ros-noetic-gmapping \
    ros-noetic-navigation \
    ros-noetic-interactive-markers \
    ros-noetic-dwa-local-planner

WORKDIR /catkin_ws/

# User in container by default is root, in root group. So all files created by it
# will also be owned by root and group root. Because of that, they will not be
# immediatelly accessible on host machine, as we access them by our user and our groups.
# Below is solution to that, we create a user in container that will match our host machine user (not by name but by ids)
# and we change group of necessary files to newly created group matching host machine user primary group. This way we can
# use those files without changing the ownership every time we create some file from cotainer (by hand or by any command)
# and we also are not operating as root which is safer.
RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
RUN chgrp -R $GROUP_ID /opt/ros/noetic && chgrp -R $GROUP_ID /catkin_ws
RUN chown -R $USER_ID /opt/ros/noetic && chown -R $USER_ID /catkin_ws

USER user
