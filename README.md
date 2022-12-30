# HTTP Status Checker
This tool is a command-line tool that checks the HTTP status codes of a list of URLs and outputs the results to the terminal and a set of files in an "outputs" folder.

### Requirements
- Bash shell
- cURL

### Usage
To use the script, first make sure it is executable:
```
chmod +x http_status_checker.sh
```
Then run the script with the path to the input file as the only argument:

```
./http_status_checker.sh [options] <input_file>
```

### Options
- `-o <output_file>`: Write the results to the specified file in addition to the terminal and the "outputs" folder.

### Input File
The input file should be a text file with one URL per line.

### Output
The script will print the HTTP status code and URL to the terminal, with different colors according to the status code:

- 200, 201, and 204: Green
- 400-499: Yellow
- 500+: Red

The script will also create a file in the "outputs" folder for each status code, and write the status code and URL to the corresponding file.

If the `-o` option is specified, the script will write the status code and URL to the specified file as well.

### Examples
Check the HTTP status codes of the URLs in urls.txt and write the results to `output.txt`:
```
./http_status_checker.sh -o output.txt urls.txt
```

Check the HTTP status codes of the URLs in `urls.txt` and only write the results to the terminal and the "outputs" folder:
```
./http_status_checker.sh urls.txt
```
