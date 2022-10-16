FROM osrf/ros:noetic-desktop-full

RUN echo "source opt/ros/noetic/setup.bash" >> /etc/bash.bashrc

# Hush debconf(Debian package configuration system) complaints
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y \
    vim \
    mesa-utils \
    ros-noetic-rviz \
    git

RUN apt-get -y install ros-noetic-desktop-full \
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

WORKDIR /catkin_ws/src
RUN git clone https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git && \
    git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3.git && \
    git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations

WORKDIR /catkin_ws/
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_make"

