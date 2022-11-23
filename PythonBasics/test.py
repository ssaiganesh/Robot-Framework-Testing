b, c, d = 5, 6.4, "Test"
print("{} {}".format("Value is ", b))
values = [1, 2, "ganesh", 4, 5]
# List is data type that allows multiple values and can be different data types
print(values[0])  # 1
print(values[-1])  # 5
print(values[1:3])  # 2 ganesh
values.insert(3, "shankar")  # 1, 2, ganesh, shankar, 4, 5
values.append("End")  # 1, 2, ganesh, shankar, 4, 5, End
values[2] = "GANESH"  # updating the value in that index
del values[0]  # 2 GANESH shankar 4 5 End

# Tuple is immutable whereas List is mutable (changeable)

val = (1, 2, "ganesh", 4, 5)
print(val[1])  # 2
# cannot update in tuple.
print("**************************************")

# Dictionary
dic = {"a": 4, 2: "bcd", "c": "hello world"}
print(dic[2])
print(dic["a"])
print("**************************************")

dic2 = {}
dic2["firstname"] = "sai Ganesh"
dic2["lastname"] = "shankar"
dic2["age"] = 26
print(dic2["lastname"])
print("**************************************")

greeting = "Good Morning"
if greeting == "Good Morning":
    print("condition matches")
    print("second line")
elif greeting == "afternoon":
    print("it is afternon!")
else:
    print("condition do not match")

#   for loop

obj = [2, 3, 5, 6, 8]
for i in obj:
    print(i)
print("**************************************")

summation = 0
for j in range(1, 6):
    print(j)  # prints till 5
    summation += j
print(summation)
print("**************************************")
j = 0
x = 0
while j < 6:
    x += j
    j += 1
print(x)
print("**************************************")

for k in range(1, 10, 2):
    print(k)  # k jumps by 2 for every loop
print("**************************************")

for m in range(10):
    print(m)  # 0 to 9
print("**************************************")

it = 10
while it > 1:
    if it == 9:
        it -= 1
        continue
        # continue skips the next few steps such as printing and it - 1 also! So loop stops That's why decrement
        # above this statement
    if it == 3:
        break
    print(it)
    it -= 1

print("while execution is done")


def GreetMe(name):
    print("Hello", name)


GreetMe("Ganesh")
