<?php
function createRandom() {
    $numbers = range(0, 10);
    shuffle($numbers);
    $index = 0;
    
    return function() use (&$numbers, &$index) {
        if ($index < count($numbers)) {
            return $numbers[$index++];
        } else {
            return "false";
        }
    };
}

$rnd = createRandom();
$results = [];
for ($i = 0; $i < 12; $i++) {
    $results[] = $rnd();
}
print_r($results);
