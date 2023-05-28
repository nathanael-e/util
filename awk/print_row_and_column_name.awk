# awk -f print_row_and_column_name.awk data.txt
# --------
# data.txt:4 Name=Bob
# data.txt:4 Age=27
# data.txt:4 City=Los Angeles
# --------
# data.txt:4 Name=Bob
# data.txt:4 Age=27
# data.txt:4 City=Los Angeles
# --------
#
BEGIN {
    FS = "|"
    filter = "Bob"
    exact = 0
}

# Process header row
NR == 1 {
    for (i = 1; i <= NF; i++) {
        header[i] = $i
    }
}

# Process data rows
NR > 1 {
    flag = 0
    for (i = 1; i <= NF; i++) {
        row[i] = header[i] "=" $i
        if (exact) {
            if (index($i, filter) != 0) {
                flag = 1;
            }
        } else {
            if (index(tolower($i), tolower(filter)) != 0) {
                flag = 1;
            }
        }
    }
    if (flag) {
        print "--------"
        for (i = 1; i <= length(row); i++) {
            print FILENAME ":" NR, row[i]
        }
    }
}

END {
    print "--------"
}

# One line
BEGIN { FS = "|"; filter = "Bob"; exact = 0 } NR == 1 { for (i = 1; i <= NF; i++) { header[i] = $i } } NR > 1 { flag = 0; for (i = 1; i <= NF; i++) { row[i] = header[i] "=" $i; if (exact) { if (index($i, filter) != 0) { flag = 1; } } else { if (index(tolower($i), tolower(filter)) != 0) { flag = 1; } } } if (flag) { print "--------"; for (i = 1; i <= length(row); i++) { print FILENAME ":" NR, row[i] } } } END { print "--------" }
