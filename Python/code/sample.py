
import time
students = {

}

grades = [
    ('elliot', 91),
    ('neelam', 98),
    ('bianca', 81),
    ('elliot', 88),
]
t1 = time.time_ns()
{students.setdefault(k, []).append(v) for k,v in grades}
t2 = time.time_ns()
# print(students)
# print(t2-t1)

from collections import defaultdict

student_grades = defaultdict(list)
t3 = time.time_ns()
for name, grade in grades:
    student_grades[name].append(grade)
t4 = time.time_ns()
# print(student_grades)
# print(t4-t3)



import sys
words = "if there was there was but if there was not there was no \
t if there was there was but if there was not there was not there \
 was not if there was there was but if there was not there was not \
 there was not if there was there was but if there was not there was \
  not there was not if there was there was but if there was not there \
  was not there was not if there was there was but if there was not there was not ".split()
count = {}
t1 = t2 =  t3 = t4 = 0
t1 = time.time_ns()
wc = (w for w in words)
for v in next(wc):
    if v in count:
        count[v] = count[v] + 1
    else:
        count[v] = 1
t2 = time.time_ns()
# print("size : " + str(sys.getsizeof(count)))
from collections import Counter
t3 = time.time_ns()
counts = Counter(words)
t4 = time.time_ns()
# print("size : " + str(sys.getsizeof(counts)))
# print(t2-t1, t4-t3)


def add_it_up(n):
    return sum(range(0,n)) if isinstance(n, int) else 0



import string
def caesar_cipher(msg, n):
    alphabets = list(string.ascii_lowercase)
    result = ""
    
    for letter in msg:
        if str.isalpha(letter):
            index = alphabets.index(letter) + n 
            if index > len(alphabets):
                result += alphabets[index - len(alphabets)]
            else:
                result += alphabets[index]
        else:
            result += letter
    return result

print(caesar_cipher("abcd xyz 3432432", 4))


