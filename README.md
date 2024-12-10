Detailed Description of the Assembly Selection Sort Algorithm
The provided assembly code implements the Selection Sort algorithm, which is a fundamental and easy to implement sorting algorithm.

1. Data Section

Constants and Messages:
  Various messages and prompts are defined, such as messages for user input, validation, and displaying the sorted and unsorted arrays.
   
Array Definition:
  An array "arr" is defined to hold the characters entered by the user. It can store a maximum of 10 elements, including a sentinel value ('$') to mark the end of the input.
   
Variables:
  Various variables are defined to keep track of the array size, current indices in the sorting process, and the index of the minimum element during sorting.
        
2. Code Section

Main Procedure:
  The program starts execution from the main procedure. It clears the screen, initializes the data segment, and calls a series of procedures to handle user input and sorting.

Input Handling:
  The EnterArraySize procedure prompts the user to input the size of the array, ensuring it falls within the range of 3 to 9. Invalid inputs lead to a re-prompting until a valid size is entered.

Array Initialization:
  The ResetArrayToNull procedure initializes the array to a default state, filling it with the sentinel character ('$').

Reading Input Characters:
  The program reads a specified number of characters from the user into arr using a loop. Each character is stored in the array, and the input process continues until the required number of characters is received.

Selection Sort Implementation:
  The core of the sorting algorithm is implemented using nested loops:

1-Outer Loop:
  The outer loop iterates through each element in the array. For each element, it assumes that the current position holds the minimum element.

2-Inner Loop:
  The inner loop compares the current element with the subsequent elements to find the actual minimum value. If a smaller value is found, it updates the minimum index.

3-Swapping:
  Once the minimum value is identified after the inner loop completes, the algorithm swaps this minimum value with the current element in the outer loop.

4-This process continues until all elements are sorted.

Output of Results:
  After sorting, the program displays both the original (unsorted) and sorted arrays using the printArray procedure. Each character is printed with a comma separator, and the output is formatted for readability.

Re-running the Program:
  After outputting the results, the program prompts the user to press any key to try again or press 'ESC' to exit. This allows for multiple sorting operations in a single execution session.

3. Subroutines

getCurrentMinNumberIndex: This procedure is responsible for determining the minimum value's index during the inner loop of selection sort.
  
CLEAR_SCREEN: Clears the console screen for better user experience between prompts and outputs. --> Code from emu8086 examples
  
NewLine: Outputs a new line for better formatting.

printArray: Displays the contents of the array, iterating through each character and formatting the output correctly.

4. Conclusion
This program showcases fundamental programming concepts in assembly language, including loops, conditionals, and procedures, making it a valuable learning resource for those studying low-level programming.
This program effectively demonstrates the Selection Sort algorithm while also providing a user-friendly interface for input and output.
The choice of Selection Sort is suitable for educational purposes and small data sizes, as it is easy to understand and implement.
