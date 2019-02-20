function() {
    var scriptPrime ="function getPrimes(max) {\n    var sieve = [], i, j, primes = [];\n    for (i = 2; i <= max; ++i) {\n        if (!sieve[i]) {\n            // i has not been marked -- it is prime\n            primes.push(i);\n            for (j = i << 1; j <= max; j += i) {\n                sieve[j] = true;\n            }\n        }\n    }\n    return primes;\n}\n \nfunction main(params) {\n    return {\n        primes:getPrimes(params.number)\n    }\n \n}";
    return scriptPrime;
}
//Sample Hello World Functions
/**
 *  Copyright 2017-2018 Adobe.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *          http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
