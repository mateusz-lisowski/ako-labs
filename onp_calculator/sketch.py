def convert_to_digit(index: int, formula: str) -> tuple[int, int]:
    i = index
    number = ''

    while formula[i] != ' ':
        number += formula[i]
        i += 1

    return int(number), i


def calculate_rpn(formula: str) -> int:
    POSSIBLE_OPERANDS = ['+', '-', '*', '/']
    IGNORED_CHARS = [' ']

    stack = []

    i = 0
    while i < len(formula):

        sign = formula[i]

        if sign.isdigit():

            res = convert_to_digit(i, formula)

            num = res[0]
            stack.append(num)

            i = res[1]
            continue

        elif sign in POSSIBLE_OPERANDS:

            num1 = stack.pop()
            num2 = stack.pop()

            if sign == '+':
                stack.append(num1 + num2)

            if sign == '-':
                stack.append(num1 - num2)

            if sign == '*':
                stack.append(num1 * num2)

            if sign == '/':
                stack.append(num2 / num1)

        elif sign in IGNORED_CHARS:
            pass

        else:
            print("Invalid formula!")
            break

        i += 1

    return stack[0]


def main():
    print("Reverse polish notation calculator")
    print("Enter valid RPN formula below")

    while True:

        formula: str = input("-> ")

        if formula == 'exit':
            break

        print(f"Result: {calculate_rpn(formula)}")


if __name__ == '__main__':
    main()
