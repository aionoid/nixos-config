import os

# Paths to the configuration files
gf_config_path = "ak/config.ini"
dso_config_path = "merged_config.ini"
output_config_path = "merged_config_2.ini"  # Output file


def parse_config(file_path):
    """Parse a configuration file and return a dictionary of sections and key-value pairs."""
    config = {}
    current_section = None

    with open(file_path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith(";"):  # Skip empty lines and comments
                continue

            # Handle section headers
            if line.startswith("[") and line.endswith("]"):
                current_section = line[1:-1]  # Remove brackets
                if current_section not in config:
                    config[current_section] = {}
                continue

            # Handle key-value pairs
            if "=" in line:
                key, value = line.split("=", 1)  # Split on the first "="
                key = key.strip()
                value = value.strip()
                if current_section:
                    config[current_section][key] = value

    return config


def merge_config_files(file1, file2, output_file):
    """Merge two configuration files into one, preserving sections, case sensitivity, and handling duplicates."""
    # Parse both configuration files
    config1 = parse_config(file1)
    config2 = parse_config(file2)

    # Merge configurations (config1 takes precedence for duplicate keys)
    merged_config = {}
    for section, keys in config1.items():
        merged_config[section] = keys.copy()

    for section, keys in config2.items():
        if section not in merged_config:
            merged_config[section] = {}
        for key, value in keys.items():
            if key not in merged_config[section]:  # Only add if key doesn't exist
                merged_config[section][key] = value

    # Write the merged configuration to the output file
    with open(output_file, "w", encoding="utf-8") as f:
        for section, keys in merged_config.items():
            f.write(f"[{section}]\n")
            for key, value in keys.items():
                f.write(f"{key}={value}\n")
            f.write("\n")  # Add a newline between sections

    print(f"Merged configuration saved to '{output_file}'.")


# Check if both input files exist
if not os.path.exists(gf_config_path):
    print(f"File '{gf_config_path}' does not exist. Skipping...")
elif not os.path.exists(dso_config_path):
    print(f"File '{dso_config_path}' does not exist. Skipping...")
else:
    # Merge the configuration files
    merge_config_files(gf_config_path, dso_config_path, output_config_path)
###########################
# import os
#
# # Paths to the configuration files
# gf_config_path = "gf/setup.ini"
# dso_config_path = "dso/setup.ini"
# output_config_path = "merged_setup.ini"  # Output file
#
#
# def parse_config(file_path):
#     """Parse a configuration file and return a dictionary of key-value pairs."""
#     config = {}
#     with open(file_path, "r", encoding="utf-8") as f:
#         for line in f:
#             line = line.strip()
#             if (
#                 line and not line.startswith("[") and "=" in line
#             ):  # Ignore section headers and empty lines
#                 key, value = line.split("=", 1)  # Split on the first "="
#                 config[key.strip()] = value.strip()
#     return config
#
#
# def merge_config_files(file1, file2, output_file):
#     """Merge two configuration files into one."""
#     # Parse both configuration files
#     config1 = parse_config(file1)
#     config2 = parse_config(file2)
#
#     # Merge the configurations (config2 overwrites config1 for duplicate keys)
#     merged_config = {**config1, **config2}
#
#     # Write the merged configuration to the output file
#     with open(output_file, "w", encoding="utf-8") as f:
#         f.write("[Common]\n")  # Write the section header
#         for key, value in merged_config.items():
#             f.write(f"{key}={value}\n")
#
#     print(f"Merged configuration saved to '{output_file}'.")
#
#
# # Check if both input files exist
# if not os.path.exists(gf_config_path):
#     print(f"File '{gf_config_path}' does not exist. Skipping...")
# elif not os.path.exists(dso_config_path):
#     print(f"File '{dso_config_path}' does not exist. Skipping...")
# else:
#     # Merge the configuration files
#     merge_config_files(gf_config_path, dso_config_path, output_config_path)
