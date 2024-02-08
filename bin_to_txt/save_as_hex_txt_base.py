import sys
import struct

def save_as_hex_txt(input_file, base_address):
    output_file = f"{input_file.rsplit('.', 1)[0]}.txt"

    with open(input_file, 'rb') as infile, open(output_file, 'w') as outfile:
        address = base_address
        while True:
            data = infile.read(4)

            # If the last group of data is less than 4 bytes, issue a warning
            if len(data) < 4:
                print("Warning: Last group of data is less than 4 bytes.")
                break

            # Unpack data with little-endian byte order
            values = struct.unpack('<I', data)

            hex_string = ' '.join(f'{value:08X}' for value in values)
            outfile.write(f'{address:08X}: {hex_string}\n')
            address += len(data)

if __name__ == "__main__":
    if len(sys.argv) == 2:
        input_file = sys.argv[1]
        base_address = 0x00000000  # Default base address
    elif len(sys.argv) == 3:
        input_file = sys.argv[1]
        try:
            base_address = int(sys.argv[2], 0)  # Interpret the base address as an integer (supports '0x' prefix)
        except ValueError:
            print("Error: Invalid base address format.")
            sys.exit(1)
    else:
        print("Usage: python script.py <input_file> [base_address]")
        sys.exit(1)

    save_as_hex_txt(input_file, base_address)
