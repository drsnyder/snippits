<?php

class A
{
    private $a = null;
    private $b = null;

    function __construct($a)
    {
    	// code...
    }

    function update($a)
    {
        $this->a = $a;
    }

    function update($a, $b)
    {
        $this->a = $a;
        $this->b = $b;
    }

    function print()
    {
        printf("a = %s, b = %s", $this->a, $this->b);
    }
}

$x = new A('1');
$x->update('2');
$x->update('2', '3');
$x->print();
