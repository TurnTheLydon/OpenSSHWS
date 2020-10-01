# OpenSSHWS
Multi User OpenSSH Windows Server Configuration

While working to implement a free SFTP server option that did not require a third-party program like FileZilla Server, I implemented OpenSSH. The next challenge was presented when it came to adding additional users that routed to specific directories. There was documentation on this for Linux OpenSSH implementations but none for Windows OpenSSH. I was finally able to add users and root directory routing through ChrootDirectory which is unofficially supported in Windows OpenSSH. 

The process to add users is as follows:

All SFTP users need to be local users on the server

    Sign in as Administrator on server and run netplwiz
    Click "Add" and create your user. They do NOT need Administrator privileges. 
    Type username NOTE: USERNAME MUST BE ALL LOWERCASE
    Type password
    Click finish

You must then create the folder this user will route to on your server and copy the file path

After the above is complete, navigate to C:\ProgramData\ssh and find sshd_config. Open this file and add the below text at the bottom or underneath any existing users.

Match User NewUsername
ChrootDirectory NewlyCreatedDirectoryPath

Replace the user "NewUsername" with your newly created user and enter directory path.


There are plans to expand this project to allow user creation and automatic addition of users to sshd_config file. Stay tuned!
