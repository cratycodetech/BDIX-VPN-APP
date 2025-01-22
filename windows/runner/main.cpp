#include <windows.h>
#include <ras.h>
#include <raserror.h>
#include <iostream>
#include <string>

#define RASEO_UseDialingRules 0x00000001

// Create the phone book entry for the network connection (IP network)
void createIpNetworkEntry(const std::wstring& networkEntryName, const std::wstring& ipAddress) {
    RASENTRYW rasEntry;
    ZeroMemory(&rasEntry, sizeof(RASENTRYW));
    rasEntry.dwSize = sizeof(RASENTRYW);

    // Set the connection options for the IP network
    rasEntry.dwfOptions = RASEO_UseDialingRules;
    rasEntry.dwFrameSize = 1500;

    // Set the IP network server address (device name)
    wcsncpy_s(rasEntry.szDeviceName, _countof(rasEntry.szDeviceName), ipAddress.c_str(), _TRUNCATE);

    // Save the IP network entry to the phone book
    DWORD dwRet = RasSetEntryProperties(NULL, networkEntryName.c_str(), &rasEntry, sizeof(RASENTRYW), NULL, 0);
    if (dwRet == 0) {
        std::wcout << L"IP Network entry created successfully!" << std::endl;
    } else {
        std::cerr << "Failed to create IP network entry. Error code: " << dwRet << std::endl;
    }
}

// Create the VPN connection entry
void createVpnEntry(const std::wstring& vpnEntryName, const std::wstring& vpnServerAddress) {
    RASENTRYW rasEntry;
    ZeroMemory(&rasEntry, sizeof(RASENTRYW));
    rasEntry.dwSize = sizeof(RASENTRYW);

    // Set the connection options for the VPN connection
    rasEntry.dwfOptions = RASEO_UseDialingRules;
    rasEntry.dwFrameSize = 1500;
    rasEntry.dwEncryptionType = 3; // Maximum encryption

    // Set the VPN server address (device name)
    wcsncpy_s(rasEntry.szDeviceName, _countof(rasEntry.szDeviceName), vpnServerAddress.c_str(), _TRUNCATE);

    // Save the VPN connection entry to the phone book
    DWORD dwRet = RasSetEntryProperties(NULL, vpnEntryName.c_str(), &rasEntry, sizeof(RASENTRYW), NULL, 0);
    if (dwRet == 0) {
        std::wcout << L"VPN entry created successfully!" << std::endl;
    } else {
        std::cerr << "Failed to create VPN entry. Error code: " << dwRet << std::endl;
    }
}

// Connect to the IP network (first RasDial)
void connectIpNetwork(const std::wstring& networkEntryName) {
    RASDIALPARAMS rasDialParams;
    ZeroMemory(&rasDialParams, sizeof(RASDIALPARAMS));
    rasDialParams.dwSize = sizeof(RASDIALPARAMS);

    // Set IP network entry name
    wcsncpy_s(rasDialParams.szEntryName, _countof(rasDialParams.szEntryName), networkEntryName.c_str(), _TRUNCATE);

    // Set network username and password
    wcsncpy_s(rasDialParams.szUserName, _countof(rasDialParams.szUserName), L"user_network", _TRUNCATE);
    wcsncpy_s(rasDialParams.szPassword, _countof(rasDialParams.szPassword), L"network_password", _TRUNCATE);

    HRASCONN hRasConn;
    DWORD dwRet = RasDial(NULL, NULL, &rasDialParams, 0, NULL, &hRasConn);

    if (dwRet == 0) {
        std::wcout << L"IP network connection established successfully!" << std::endl;
    } else {
        std::cerr << "Failed to connect to IP network. Error code: " << dwRet << std::endl;
    }
}

// Connect to the VPN (second RasDial)
void connectVpn(const std::wstring& vpnEntryName) {
    RASDIALPARAMS rasDialParams;
    ZeroMemory(&rasDialParams, sizeof(RASDIALPARAMS));
    rasDialParams.dwSize = sizeof(RASDIALPARAMS);

    // Set VPN entry name
    wcsncpy_s(rasDialParams.szEntryName, _countof(rasDialParams.szEntryName), vpnEntryName.c_str(), _TRUNCATE);

    // Set VPN username and password
    wcsncpy_s(rasDialParams.szUserName, _countof(rasDialParams.szUserName), L"root", _TRUNCATE);
    wcsncpy_s(rasDialParams.szPassword, _countof(rasDialParams.szPassword), L"vpnserver123456", _TRUNCATE);

    HRASCONN hRasConn;
    DWORD dwRet = RasDial(NULL, NULL, &rasDialParams, 0, NULL, &hRasConn);

    if (dwRet == 0) {
        std::wcout << L"VPN connection established successfully!" << std::endl;
    } else {
        std::cerr << "Failed to connect to VPN. Error code: " << dwRet << std::endl;
    }
}

int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
std::wstring networkEntryName = L"MyNetworkProfile";
std::wstring vpnEntryName = L"MyVPNProfile";
std::wstring serverAddress = L"5.223.50.93";  // VPN server address
std::wstring ipAddress = L"10.0.0.1";        // IP network address

// Step 1: Create network entry (IP network)
createIpNetworkEntry(networkEntryName, ipAddress);

// Step 2: Create VPN entry
createVpnEntry(vpnEntryName, serverAddress);

// Step 3: Connect to the IP network
connectIpNetwork(networkEntryName);

// Step 4: Connect to the VPN
connectVpn(vpnEntryName);

return 0;
}
