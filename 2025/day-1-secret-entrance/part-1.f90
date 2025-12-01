program part1
        implicit none

        integer :: position = 50
        integer :: count = 0

        character(len=256) :: line
        character :: direction
        integer :: distance
        integer :: ios

        integer :: unit
        open(newunit=unit, file='/dev/stdin', status='old', action='read')

        do
                read(unit, '(A)', iostat=ios) line
                if (ios /= 0) exit

                write(*, '(I0)', advance='no') position

                direction = line(1:1)
                read(line(2:), *) distance

                write(*, '(A,A,I0)', advance='no') " + ", direction, distance

                if (direction == 'L') then
                        distance = -distance
                end if

                write(*, '(A,I0,A)', advance='no') " (", distance, ")"

                position = position + distance

                write(*, '(A,I0,A)', advance='no') " -> ", position

                position = mod(position, 100)
                if (position < 0) then
                        position = position + 100
                end if

                if (position == 0) then
                        count = count + 1
                end if

                write(*, '(A,I0,A,I0,A)') " = ", position, " [", count, "]"
        end do

        close(unit)

        write(*, '(I0)') count
end program part1
