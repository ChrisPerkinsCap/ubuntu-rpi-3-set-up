# ubuntu-rpi-3-set-up
Scripts and instructions for setting up ubuntu-server on rpi 3

### Access a fresh install of ubuntu-server on a raspberry-pi 3

1. Connect the RPI 3 to your router with an ethernet cable and boot up
1. If you haven't configured the server to have static IP Check your routers admin interface to find it.
1. ssh on to the new server using the username: ubuntu and the password: ubuntu

    ```bash
    myuser@my-pc$ ssh ubuntu@192.168.10.256
    ubuntu@192.168.1.30's password:
    Welcome to Ubuntu 18.04.2 LTS (GNU/Linux 4.15.0-1031-raspi2 aarch64)
    
     * Documentation:  https://help.ubuntu.com
     * Management:     https://landscape.canonical.com
     * Support:        https://ubuntu.com/advantage
    ```

1. Create a new user with a group and a home directory. As requested provide a password and leave all other information blanc
    ```bash
    sudo adduser my-user
    ```

1. Add your new user to the sudoers (super user) group
    ```bash
    sudo usermod -aG sudo my-user
    ```

1. Exit and log back in as your new user
    ```bash
    myuser@my-pc$ ssh my-user@192.168.10.256
    my-user@192.168.1.30's password:
    Welcome to Ubuntu 18.04.2 LTS (GNU/Linux 4.15.0-1031-raspi2 aarch64)
    
     * Documentation:  https://help.ubuntu.com
     * Management:     https://landscape.canonical.com
     * Support:        https://ubuntu.com/advantage
    ```

1. Add the following lines 
    ```bash
    Match User ubuntu
          PasswordAuthentication no
    ```
    to the end of the /etc/ssh/sshd_config file to prevent password login by the ubuntu user 

    ```bash
    
    nano /etc/ssh/sshd_config
    
    CTR + o
    CTR + x
    ```

1. Reboot
    ```bash
    sudo reboot
    ```

1. Log back in as the new user. (see step 6.)

