import subprocess, os

def ban():
    os.system("clear")
    print("""
         _                         _             
        | |__  _ __ _____      __ | |_ ___  __ _ 
        | '_ \| '__/ _ \ \ /\ / / | __/ _ \/ _` |
        | |_) | | |  __/\ V  V /  | ||  __/ (_| |
        |_.__/|_|  \___| \_/\_/    \__\___|\__,_|
              ====[ TeaLinux Installer ]====
                  last update 3 feb 2024
    """)

### function partition
def part():
    print("[*] Showing device names:\n")
    lsblk_process = subprocess.run(["lsblk", "--output", "NAME", "--list"], capture_output=True, text=True)
    
    # Filter and print only device names
    device_names = [] # make device name save in list
    for line in lsblk_process.stdout.split('\n'):
        if line and not line.startswith("NAME"):
            device_name = line.strip()
            device_names.append(device_name)
            print(f"└── /dev/{device_name}") # output it

    return device_names # return back
### function selected drive
def set_device(selected_device, device_names):
    if selected_device in device_names:
        print(f"[*] Selected device set to: {selected_device}")
        return selected_device
    else:
        print("Invalid device name. Please select a valid device.")
### function setlected time zone
def set_time(region, city):
    # subprocess.run(["ln", "-sf", f"/usr/share/zoneinfo/{region}/{city}", "/etc/localtime"]) ## on development i command this line bcz i dont want make my machine get execute this command LOL
    # subprocess.run(["hwclock", "--systohc"])
    print(f"Timezone set to {region}/{city}")

def list_time_zones():
    print("[*] List of available time zones:\n")
    output = os.popen("ls -l /usr/share/zoneinfo/ | grep '^d' | awk '{print $NF}'").read()
    lines = output.splitlines()
    
    # Organize the output into three columns
    column_width = max(len(line) for line in lines)
    num_columns = 3
    lines_per_column = -(-len(lines) // num_columns)  # Ceiling division

    for i in range(lines_per_column):
        for j in range(num_columns):
            index = i + j * lines_per_column
            if index < len(lines):
                print(f"[*] {lines[index]:<{column_width}}", end="\t")
        print()

def list_time_city(cityin):
    print(f"[*]  List of available city in {cityin}:\n")
    os.system(f"ls /usr/share/zoneinfo/{cityin}")
    return cityin

def install_arch(selected_device):
    if selected_device:
        print(f"Installing Arch Linux with Btrfs on /dev/{selected_device}...")
        # (Your installation code here)
    else:
        print("Please set a device using 'set /dev/(device_name)' before installing.")

def help():
    os.system("clear")
    ban()
    print("""
    Tea Linux Installer Beta Version
    
    options:
    help\t\t\tShow partitons on your device
    set (device name)\t\tSetting your device partition to be place for install Tea Linux
    set user\t\t\tMake default user after installation
    set package\t\t\tList package that you want install
    set time (region) (city)\tSetting localtime
    list time zone\t\tShow all time zone
    list city (region)\t\tShow all city in the region
    exit\t\t\tExit installer   
    """)

def teaprompt():
    selected_device = None
    cityin = "Asia"  # Set default city or choose an appropriate default value
    ban()
    while True:
        user_input = input("Tea Installer > ")
        
        # Exit condition
        if user_input.lower() == 'exit':
            print("Exiting TeaLinux Installer...")
            break
        elif user_input.lower() == 'help':
            help()
        elif user_input.lower() == 'partition':
            device_names = part()
        elif user_input.lower().startswith('set /dev/'):
            selected_device = set_device(user_input[9:], device_names)
        elif user_input.lower() == 'install':
            install_arch(selected_device)
        elif user_input.lower() == 'list time zone':
            list_time_zones()
        elif user_input.lower().startswith('set time'):
            # Split the command and extract region and city
            tokens = user_input.split(' ', 3)
            if len(tokens) == 4:
                _, _, region, city = tokens
                set_time(region, city)
            else:
                print("Invalid 'set time' command format. Please use 'set time Region City'.")
        
        elif user_input.lower().startswith('list city'):
            tokens = user_input.split(' ', 2)
            if len(tokens) == 3:
                _, _, cityin = tokens
                list_time_city(cityin)
            else:
                print("Invalid 'list city' command format. Please use 'list city Regions'.")

if __name__ == "__main__":
    print("Welcome to TeaLinux Installer. Type 'help' to see all command and type 'exit' to quit.")
    teaprompt()
