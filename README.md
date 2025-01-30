# Cryptography and Network Security Labs

This repository contains all the labs completed as part of the **Cryptography and Network Security** course. The labs were primarily implemented using **Cisco Packet Tracer**, except for the **DSA** and **RSA** labs, which were implemented in **Verilog (HDL)**.

---

## Lab Overview

### **Lab 1: Social Engineering, Network Attacks, and Security Tools**
- **Objectives**:
  - Research examples of social engineering and identify ways to recognize and prevent it.
  - Research network attacks.
  - Research network security audit tools and attack tools.

---

### **Lab 2: Static and Dynamic Routing**
- **Objectives**:
  - Implement static routing with a two-router configuration.
  - Implement static routing with a three-router configuration.
  - Implement dynamic routing using OSPF.

---

### **Lab 3: OSPF MD5 Authentication, NTP, Syslog, and SSH**
- **Objectives**:
  - Configure OSPF MD5 authentication.
  - Configure NTP.
  - Configure routers to log messages to the syslog server.
  - Configure R3 to support SSH connections.

---

### **Lab 4: AAA Authentication**
- **Objectives**:
  - Configure a local user account on R1 and authenticate on the console and vty lines using local AAA.
  - Verify local AAA authentication from the R1 console and the PC-A client.
  - Configure server-based AAA authentication using TACACS+.
  - Verify server-based AAA authentication from the PC-B client.
  - Configure server-based AAA authentication using RADIUS.
  - Verify server-based AAA authentication from the PC-C client.

---

### **Lab 5: Access Control Lists (ACLs)**
- **Objectives**:
  - Configure, apply, and verify a standard named ACL.
  - Configure, apply, and verify a standard numbered ACL.
  - Configure, apply, and verify an extended numbered ACL.

---

### **Lab 6: Extended ACLs and IPv6 ACLs**
- **Objectives**:
  - Configure, apply, and verify an extended numbered ACL.
  - Verify connectivity among devices before firewall configuration.
  - Use ACLs to ensure remote access to the routers is available only from the management station PC-C.
  - Configure and verify ACLs on R1 and R3 to mitigate attacks.
  - Configure, apply, and verify an IPv6 ACL.

---

### **Lab 7: Zone-Based Policy Firewall (ZPF)**
- **Objectives**:
  - Verify connectivity among devices before firewall configuration.
  - Configure a zone-based policy (ZPF) firewall on R3.
  - Verify ZPF firewall functionality using ping, SSH, and a web browser.

---

### **Lab 8: Intrusion Prevention System (IPS)**
- **Objectives**:
  - Enable IOS IPS.
  - Configure logging.
  - Modify an IPS signature.
  - Verify IPS.

---

### **Lab 9: Securing Spanning-Tree Protocol (STP) and Port Security**
- **Objectives**:
  - Assign the Central switch as the root bridge.
  - Secure spanning-tree parameters to prevent STP manipulation attacks.
  - Enable port security to prevent CAM table overflow attacks.

---

### **Lab 10: Data Encryption Standard (DES)**
- **Objectives**:
  - Perform the initial permutation and final permutation.
  - Construct the DES function.
  - Design the Key Generator function.
  - Implement the Cipher algorithm.
  - Encrypt data using the DES algorithm.
  - Validate the DES implementation with various inputs.

---

### **Lab 11: RSA Encryption**
- **Objectives**:
  - Generate an RSA encryption key pair.
  - Implement encryption and decryption using RSA.

---

### **Lab 12: IPsec VPN**
- **Objectives**:
  - Verify connectivity throughout the network.
  - Configure R1 to support a site-to-site IPsec VPN with R3.

---

### **Lab 13: ASA Firewall Configuration**
- **Objectives**:
  - Verify connectivity and explore the ASA.
  - Configure basic ASA settings and interface security levels using CLI.
  - Configure routing, address translation, and inspection policy using CLI.
  - Configure DHCP, AAA, and SSH.
  - Configure a DMZ, static NAT, and ACLs.

---

## Tools Used
- **Cisco Packet Tracer**: For network simulations and configurations.
- **Verilog (HDL)**: For implementing DSA and RSA algorithms.

---

## Repository Structure
- Each lab is organized into its respective folder (e.g., `Lab1`, `Lab2`, etc.).
- Lab folders contain:
  - Configuration files (`.pkt` for Packet Tracer).
  - Respective Slides that Professor provided us for better understanding
  - Verilog source files (for Labs 10 and 11).
  - Documentation or reports (if applicable).

---

## How to Use
1. Clone the repository:
   ```bash
   git clone https://github.com/AsgharAZ/Cryptography_Labs.git
