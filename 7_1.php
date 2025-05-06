function createFib($a, $b) {
    $prev = $a;
    $current = $b;
    
    return function() use (&$prev, &$current) {
        $next = $prev + $current;
        $prev = $current;
        $current = $next;
        return $next;
    };
}

$fibA = createFib(1, 1);
echo $fibA() . "\n"; // 2
echo $fibA() . "\n"; // 3
echo "\n"

$fibB = createFib(0, 2);
echo $fibB() . "\n"; // 2
echo $fibB() . "\n"; // 4
echo $fibB() . "\n"; // 6
