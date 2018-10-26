
{ ->
	print("Hello, world!\n");
	print("Hi!", "\n");
	println("你好");
}



{_true, _false, _if ->
    _true = {(t, f) -> t};
    _false = {(t, f) -> f};
    _if = {(c, t, e) -> c(t, e)()};

    println(_if(_false, {-> while true do {} od}, {-> "False"}))
}


{average, sqr, abs, sqrt, x ->
    average = {(x, y) -> (x + y) / 2};
    sqr = {(x) -> x * x};
    abs = {(x) -> if x >= 0 then x else -x fi};
    sqrt = {(x) tolerance, isGoodEnough, improve, sqrtIter ->
        tolerance = 1e-30;

        isGoodEnough = {(guess) -> abs(sqr(guess) - x) < tolerance};
        improve = {(guess) -> average(guess, x / guess)};
        sqrtIter = {(guess) ->
            if isGoodEnough(guess) then guess else sqrtIter(improve(guess)) fi
        };
        sqrtIter(1)
    };

    x = 2.3;
    println("sqrt(", x, "): ", sqrt(x));
}




{coin, change ->
    coin = {(index) ->
        if index == 0
        then 500
        else if index == 1
            then 200
            else if index == 2
                then 100
                else if index == 3
                    then 50
                    else if index == 4
                        then 20
                        else if index == 5
                            then 10
                            else if index == 6
                                then 5
                                fi
                            fi
                        fi
                    fi
                fi
            fi
        fi
    };

    change = {(amount, index) ->
        if amount == 0 then 1
        else if amount < 0 then 0
            else if index >= 7 then 0
                else change(amount, index + 1) + change(amount - coin(index), index)
                fi
            fi
        fi
    };

    println(change(10, 0))
}



{makeCounter, myCounter, yourCounter, n ->

    makeCounter = {(balance) ->
        {(amount) -> balance += amount}
    };

    myCounter = makeCounter(100);
    yourCounter = makeCounter(50);

    println("myCounter: ", myCounter(0));
    println("yourCounter: ", yourCounter(0));
    println();

    n = 0;
    while n < 10 do
        println("myCounter[", n, "]: ", myCounter(50));
        println("yourCounter[", n, "]: ", yourCounter(-10));
        println();
        n += 1
    od
}




{isOdd, isEven ->
	isOdd = {(n) -> if n == 0 then false else isEven(n - 1) fi};
	isEven = {(n) -> if n == 0 then true else isOdd(n - 1) fi};

	println(isEven(1000));
}




{a ->
    println(1 / 317);

    a = 1024 * 1024 * 1024 * 1024 * 1024 * 1024 * 1024 * 1024 * 1024;
    println(a);
    println(1 / a);
    println(1 / a * a);
    println(1 / a * a == 1);

    println(3.27 % .7);
}



{fib ->
    fib = {(n) ->
        if n < 2 then n else fib(n - 1) + fib(n - 2) fi
    };

    println(fib(40))
}



{fib ->
    fib = {(n) fib0, fib1, fib ->
        fib0 = 1;
        fib1 = 0;
        while n > 0 do
            fib = fib0 + fib1;
            fib0 = fib1;
            fib1 = fib;
            n -= 1
        od;
        fib1
    };

    println(fib(10000))
}

{hanoi ->
    hanoi = {(n, from, to, via) ->
        if n > 0 then
            hanoi(n - 1, from, via, to);
            println(from, " -> ", to);
            hanoi(n - 1, via, to, from)
        fi
    };
    hanoi(10, "left", "right", "center")
}





{ pair, head, tail, tree ->
    pair = {(h, t) -> {(p) -> p(h, t)}};
    head = {(p) -> p({(h, t) -> h})};
    tail = {(p) -> p({(h, t) -> t})};

    tree = pair(1, pair(pair("two", 42), pair(true, nil)));
    println(tail(head(tail(tree))));
}


// a line comment