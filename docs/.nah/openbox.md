# Development Container Setup

This guide will help you set up a development container with a **browser**, **Openbox**, and **noVNC**. Feel free to use it for your projects or as a reference.

## Setup Instructions

1. **Update the package list and install dependencies:**

```bash
sudo apt update
sudo apt install openbox firefox tigervnc-standalone-server
```

2. **Clone the noVNC repository and set up the VNC server:**

```bash
cd
git clone https://github.com/novnc/noVNC
cd noVNC
```

3. **Start the VNC server with Openbox as the window manager:**

```bash
vncserver -xstartup "openbox"
```

4. **Launch noVNC to access your VNC session via a web browser:**

```bash
./utils/novnc_proxy --vnc localhost:5901
```

---

## Accessing the Application

Once the VNC server and noVNC are up and running, you can access the development container via a web browser.

- **Right-click** on the screen to open the context menu.
- Navigate to **Applications > Firefox Web Browser** to start browsing.

---

## Credits

This setup was created by [G-flame](https://github.com/g-flame). Feel free to use and modify it as needed!

---
