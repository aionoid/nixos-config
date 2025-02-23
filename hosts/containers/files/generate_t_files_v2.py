import os
import re


def is_text(value):
    """
    Check if a value is text (non-numeric, non-alphanumeric, and non-empty).
    """
    if not value:
        return False
    # Ignore numeric values (e.g., "80007") and alphanumeric values (e.g., "G00005")
    if re.match(r"^-?\d+$", value) or re.match(r"^[A-Za-z]\d+$", value):
        return False
    # Check if the value contains any non-numeric, non-alphanumeric characters
    return not re.match(r"^[A-Za-z0-9_-]+$", value)


def detect_text_columns(columns):
    """
    Detect columns that contain text (excluding numeric and alphanumeric values).
    """
    text_columns = []
    for i, column in enumerate(columns):
        if is_text(column):
            text_columns.append(i + 1)  # Column index starts from 1
    return text_columns


def generate_t_file(s_file_path, t_file_path):
    """
    Generate a T_* file from an S_* file.
    """
    try:
        # with open(s_file_path, "r", encoding="big5", errors="replace") as s_file, open(
        with open(s_file_path, "r", encoding="big5", errors="ignore") as s_file, open(
            t_file_path, "w", encoding="big5"
        ) as t_file:
            # Read the entire file content
            file_content = s_file.read()

            # Split the file content into rows based on the ID column (e.g., "10001|")
            rows = re.split(r"\n(?=\d+\|)", file_content)

            # Check if the file has at least one row (header + data)
            if len(rows) < 2:
                print(
                    f"Skipping file {s_file_path} because it doesn't contain any valid rows."
                )
                return

            # Process the first row to get the version and number of columns
            first_row = rows[0].strip()
            try:
                version = first_row.split("|")[1]  # Extract version (e.g., "V.7")
                num_columns = int(
                    first_row.split("|")[2]
                )  # Extract number of columns (e.g., 68)
            except IndexError:
                print(
                    f"Skipping file {s_file_path} due to malformed first row: {first_row}"
                )
                return

            # Write the header for the T_* file
            t_file.write(
                f"{version}|{len([1])}|\n"
            )  # Placeholder for number of columns

            # Process each row
            text_columns = None
            for row in rows[1:]:  # Skip the first row (header)
                row = row.strip()
                if not row or row.startswith("#"):  # Skip empty lines or comments
                    continue

                # Split the row into columns
                columns = row.split("|")

                # Detect text columns (only once, using the first data row)
                if text_columns is None:
                    text_columns = [1] + detect_text_columns(
                        columns
                    )  # Always include the first column (ID)
                    if len(text_columns) == 1:  # No text columns detected
                        print(
                            f"Skipping file {s_file_path} because it doesn't contain any text columns."
                        )
                        return
                    t_file.write(
                        "|".join(map(str, text_columns)) + "|\n"
                    )  # Write the column indices

                # Ensure the text_columns are within the range of the current row's columns
                valid_text_columns = [i for i in text_columns if i <= len(columns)]

                # Extract the required columns
                extracted_columns = [
                    columns[i - 1] for i in valid_text_columns
                ]  # Adjust for 1-based indexing

                # Write the extracted columns to the T_* file
                t_file.write("|".join(extracted_columns) + "|\n")

        print(f"Generated {t_file_path} successfully!")
    except UnicodeDecodeError as e:
        print(f"Skipping file {s_file_path} due to decoding error: {e}")


def process_folder(folder_path):
    """
    Process all S_* files in the folder and generate T_* files.
    """
    for filename in os.listdir(folder_path):
        if filename.startswith("S_") and filename.endswith(".ini"):
            s_file_path = os.path.join(folder_path, filename)
            t_file_path = os.path.join(folder_path, filename.replace("S_", "T_"))
            generate_t_file(s_file_path, t_file_path)


# Example usage
folder_path = "db"  # Folder containing S_* files
process_folder(folder_path)
