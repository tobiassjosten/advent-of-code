package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

main :: proc() {
	count := 0;

	buf, _ := os.read_entire_file_from_handle(os.stdin);
	input := strings.trim_space(string(buf));

	for range in strings.split(input, ",") {
		ends := strings.split(range, "-");
		if len(ends) != 2 {
			fmt.println("Invalid range:", range);
			continue;
		}

		from, fromOK := strconv.parse_int(ends[0]);
		if !fromOK {
			fmt.println("Invalid start in range:", range);
			continue;
		}

		to, toOK := strconv.parse_int(ends[1]);
		if !toOK {
			fmt.println("Invalid end in range:", range);
			continue;
		}

		number:
		for i in from..=to {
			buf: [128]byte;
			s := strconv.write_int(buf[:], i64(i), 10);

			chunk:
			for chunkSize in 1..=(len(s)/2) {
				if len(s)% chunkSize != 0 {
					continue;
				}

				for chunkIndex in 0..<((len(s)/chunkSize)-1) {
					if s[chunkSize*chunkIndex:chunkSize*(chunkIndex+1)] != s[chunkSize*(chunkIndex+1):chunkSize*(chunkIndex+2)] {
						continue chunk;
					}
				}

				count += i;

				continue number;
			}
		}
	}

	fmt.println(count);
}

// 46769308485
