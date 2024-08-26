class Solution:
    def runLengthEncoding(self, code: str) -> str:
        rle_code = ""
        current_duplicates = code[0]
        num = 1
        for char in code[1:]:
            if char == current_duplicates:
                num += 1
            else:
                rle_code += f"{num}{current_duplicates}"
                current_duplicates = char
                num = 1
        rle_code += f"{num}{current_duplicates}"
        return rle_code
    def countAndSay(self, n: int) -> str:
        """
        thought:
        - based on the problem description, we can define the function countAndSay(n) as follows:
            1. countAndSay(1) = '1'
            2. For n > 1, countAndSay(n) is the run-length encoding (RLE) of countAndSay(n-1).
        - the key point is to create a function that performs the run-length encoding (RLE) process.
        - therefore, we can follow these steps:
            (1) define a `runLengthEncoding` function.
            (2) define a variable `code` to store the result of the run-length encoding and a variable `i` to track the current iteration.
            (3) while `i` is less than or equal to `n`, keep applying the run-length encoding and updating the `code` variable.
        """
        code = "1"
        i = 2
        while i <= n:
            code = self.runLengthEncoding(code)
            i += 1
        return code
