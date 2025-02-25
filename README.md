# 🔪 SAK - Swiss Army Knife for 🛠️ DevOps

SAK (🔪 Swiss Army Knife) is a collection of 🖥️ Bash scripts designed to simplify and automate various DevOps tasks. It includes utilities for 🏥 system monitoring, 📦 backups, 🌍 server health checks, and more.

## ⭐ Features
- 🔄 Automated system backups
- 🏥 Server health monitoring
- 📜 Log management
- 🌐 Network diagnostics

## 📥 Installation

### **🔹 Option 1: Install via 📦 .deb Package (Recommended for 🐧 Debian/Ubuntu Users)**

1. **📩 Download the latest `.deb` package**
   ```bash
   wget https://github.com/bdiwy/sak/releases/latest/download/sak.deb
   ```

2. **📦 Install the package**
   ```bash
   sudo dpkg -i sak.deb
   ```
   If there are missing dependencies, fix them with:
   ```bash
   sudo apt-get install -f
   ```

### **🔹 Option 2: Manual Installation**
If you prefer to install manually:

1. **📂 Clone the repository**
   ```bash
   git clone https://github.com/bdiwy/sak.git
   ```

2. **📁 Move to the project directory**
   ```bash
   cd sak
   ```

3. **🔓 Make the script executable**
   ```bash
   chmod +x main.sh
   ```

4. **🚀 Move it to `/usr/local/bin/` for global access**
   ```bash
   sudo mv main.sh /usr/local/bin/sak
   ```

5. **▶️ Run the tool**
   ```bash
   sak
   ```

## 🏃 Usage
Once installed, you can run SAK using:
```bash
sak
```

It will provide an 🎛️ interactive menu with available tools.

## 🔄 Updating SAK
To update to the latest version:
```bash
wget https://github.com/bdiwy/sak/releases/latest/download/sak.deb
sudo dpkg -i sak.deb
```

## 🤝 Contributing
Feel free to contribute by submitting 📝 issues or 🔀 pull requests to the [GitHub repository](https://github.com/bdiwy/sak).

## 📜 License
SAK is released under the ⚖️ MIT License. See [LICENSE](LICENSE) for more details.

