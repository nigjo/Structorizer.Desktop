10 REM Tries to read as many integer values as possible upto maxNumbers 
20 REM from file fileName into the given array numbers. 
30 REM Returns the number of the actually read numbers. May cause an exception. 
40 REM Generated by Structorizer 3.30-11 
50 
60 REM Copyright (C) 2020-03-21 Kay Gürtzig 
70 REM License: GPLv3-link 
80 REM GNU General Public License (V 3) 
90 REM https://www.gnu.org/licenses/gpl.html 
100 REM http://www.gnu.de/documents/gpl.de.html 
110 
120 REM  
130 REM TODO: Add type-specific suffixes where necessary! 
140 FUNCTION readNumbers(fileName AS String, numbers AS array of integer, maxNumbers AS integer) AS integer
150   REM TODO: add the respective type suffixes to your variable names if required 
160   LET nNumbers = 0
170   LET fileNo = fileOpen(fileName)
180   IF fileNo <= 0 THEN
190     REM FIXME: Only a number is allowed as parameter: 
200     ERROR "File could not be opened!"
210   END IF
220   ON ERROR GOTO 300
230   DO WHILE NOT fileEOF(fileNo) AND nNumbers < maxNumbers
240     LET number = fileReadInt(fileNo)
250     LET numbers(nNumbers) = number
260     LET nNumbers = nNumbers + 1
270   LOOP
280   GOTO 330
290   REM Start of error handler, FIXME: variable 'error' should conatain error info ... 
300     REM FIXME: Only a number is allowed as parameter: 
310     ERROR 
320   REM End of error handler, resume here ... 
330   ON ERROR GOTO 0
340   fileClose(fileNo)
350   RETURN nNumbers
360 END FUNCTION
370 REM  
380 REM Draws a bar chart from the array "values" of size nValues. 
390 REM Turtleizer must be activated and will scale the chart into a square of 
400 REM 500 x 500 pixels 
410 REM Note: The function is not robust against empty array or totally equal values. 
420 REM TODO: Add type-specific suffixes where necessary! 
430 SUB drawBarChart(values AS array of double, nValues)
440   REM TODO: add the respective type suffixes to your variable names if required 
450   REM Used range of the Turtleizer screen 
460   LET xSize = 500
470   LET ySize = 500
480   LET kMin = 0
490   LET kMax = 0
500   FOR k = 1 TO nValues-1
510     IF values(k) > values(kMax) THEN
520       LET kMax = k
530     ELSE
540       IF values(k) < values(kMin) THEN
550         LET kMin = k
560       END IF
570     END IF
580   NEXT k
590   LET valMin = values(kMin)
600   LET valMax = values(kMax)
610   LET yScale = valMax * 1.0 / (ySize - 1)
620   LET yAxis = ySize - 1
630   IF valMin < 0 THEN
640     IF valMax > 0 THEN
650       LET yAxis = valMax * ySize * 1.0 / (valMax - valMin)
660       LET yScale = (valMax - valMin) * 1.0 / (ySize - 1)
670     ELSE
680       LET yAxis = 1
690       LET yScale = valMin * 1.0 / (ySize - 1)
700     END IF
710   END IF
720   REM draw coordinate axes 
730   gotoXY(1, ySize - 1)
740   forward(ySize -1) : REM color = ffffff
750   penUp()
760   backward(yAxis) : REM color = ffffff
770   right(90)
780   penDown()
790   forward(xSize -1) : REM color = ffffff
800   penUp()
810   backward(xSize-1) : REM color = ffffff
820   LET stripeWidth = xSize / nValues
830   FOR k = 0 TO nValues-1
840     LET stripeHeight = values(k) * 1.0 / yScale
850     SELECT CASE k % 3
860       CASE 0
870         setPenColor(255,0,0)
880       CASE 1
890         setPenColor(0, 255,0)
900       CASE 2
910         setPenColor(0, 0, 255)
920     END SELECT
930     fd(1) : REM color = ffffff
940     left(90)
950     penDown()
960     fd(stripeHeight) : REM color = ffffff
970     right(90)
980     fd(stripeWidth - 1) : REM color = ffffff
990     right(90)
1000     forward(stripeHeight) : REM color = ffffff
1010     left(90)
1020     penUp()
1030   NEXT k
1040 END SUB

REM = = = = 8< = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

1050 REM ======= 8< =========================================================== 
1060 
1070 REM Computes the sum and average of the numbers read from a user-specified 
1080 REM text file (which might have been created via generateRandomNumberFile(4)). 
1090 REM  
1100 REM This program is part of an arrangement used to test group code export (issue 
1110 REM #828) with FileAPI dependency. 
1120 REM The input check loop has been disabled (replaced by a simple unchecked input 
1130 REM instruction) in order to test the effect of indirect FileAPI dependency (only the 
1140 REM called subroutine directly requires FileAPI now). 
1150 REM Generated by Structorizer 3.30-11 
1160 
1170 REM Copyright (C) 2020-03-21 Kay Gürtzig 
1180 REM License: GPLv3-link 
1190 REM GNU General Public License (V 3) 
1200 REM https://www.gnu.org/licenses/gpl.html 
1210 REM http://www.gnu.de/documents/gpl.de.html 
1220 
1230 REM  
1240 REM program ComputeSum
1250 REM TODO: add the respective type suffixes to your variable names if required 
1260 LET fileNo = 1000
1270 REM Disable this if you enable the loop below! 
1280 PRINT "Name/path of the number file"; : INPUT file_name
1290 REM If you enable this loop, then the preceding input instruction is to be disabled 
1300 REM and the fileClose instruction in the alternative below is to be enabled. 
1310 REM DO 
1320 REM   PRINT "Name/path of the number file"; : INPUT file_name 
1330 REM   LET fileNo = fileOpen(file_name) 
1340 REM LOOP UNTIL fileNo > 0 OR file_name = "" 
1350 IF fileNo > 0 THEN
1360   REM This should be enabled if the input check loop above gets enabled. 
1370 REM   fileClose(fileNo) 
1380   REM TODO: Check indexBase value (automatically generated) 
1390   LET indexBase = 0
1400   LET nValues = 0
1410   ON ERROR GOTO 1450
1420   LET nValues = readNumbers(file_name, values, 1000)
1430   GOTO 1480
1440   REM Start of error handler, FIXME: variable 'failure' should conatain error info ... 
1450     PRINT failure
1460     STOP
1470   REM End of error handler, resume here ... 
1480   ON ERROR GOTO 0
1490   LET sum = 0.0
1500   FOR k = 0 TO nValues-1
1510     LET sum = sum + values(k)
1520   NEXT k
1530   PRINT "sum = "; sum
1540   PRINT "average = "; sum / nValues
1550 END IF
1560 END

REM = = = = 8< = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

1570 REM ======= 8< =========================================================== 
1580 
1590 REM Reads a random number file and draws a histogram accotrding to the 
1600 REM user specifications 
1610 REM Generated by Structorizer 3.30-11 
1620 
1630 REM Copyright (C) 2020-03-21 Kay Gürtzig 
1640 REM License: GPLv3-link 
1650 REM GNU General Public License (V 3) 
1660 REM https://www.gnu.org/licenses/gpl.html 
1670 REM http://www.gnu.de/documents/gpl.de.html 
1680 
1690 REM  
1700 REM program DrawRandomHistogram
1710 REM TODO: add the respective type suffixes to your variable names if required 
1720 LET fileNo = -10
1730 DO
1740   PRINT "Name/path of the number file"; : INPUT file_name
1750   LET fileNo = fileOpen(file_name)
1760 LOOP UNTIL fileNo > 0 OR file_name = ""
1770 IF fileNo > 0 THEN
1780   fileClose(fileNo)
1790   PRINT "number of intervals"; : INPUT nIntervals
1800   REM Initialize the interval counters 
1810   FOR k = 0 TO nIntervals-1
1820     LET count(k) = 0
1830   NEXT k
1840   REM Index of the most populated interval 
1850   LET kMaxCount = 0
1860   REM TODO: Check indexBase value (automatically generated) 
1870   LET indexBase = 0
1880   LET nObtained = 0
1890   ON ERROR GOTO 1930
1900   LET nObtained = readNumbers(file_name, numberArray, 10000)
1910   GOTO 1950
1920   REM Start of error handler, FIXME: variable 'failure' should conatain error info ... 
1930     PRINT failure
1940   REM End of error handler, resume here ... 
1950   ON ERROR GOTO 0
1960   IF nObtained > 0 THEN
1970     LET min = numberArray(0)
1980     LET max = numberArray(0)
1990     FOR i = 1 TO nObtained-1
2000       IF numberArray(i) < min THEN
2010         LET min = numberArray(i)
2020       ELSE
2030         IF numberArray(i) > max THEN
2040           LET max = numberArray(i)
2050         END IF
2060       END IF
2070     NEXT i
2080     REM Interval width 
2090     LET width = (max - min) * 1.0 / nIntervals
2100     FOR i = 0 TO nObtained - 1
2110       LET value = numberArray(i)
2120       LET k = 1
2130       DO WHILE k < nIntervals AND value > min + k * width
2140         LET k = k + 1
2150       LOOP
2160       LET count(k-1) = count(k-1) + 1
2170       IF count(k-1) > count(kMaxCount) THEN
2180         LET kMaxCount = k-1
2190       END IF
2200     NEXT i
2210     CALL drawBarChart(count, nIntervals)
2220     PRINT "Interval with max count: "; kMaxCount; " ("; count(kMaxCount); ")"
2230     FOR k = 0 TO nIntervals-1
2240       PRINT count(k); " numbers in interval "; k; " ("; min + k * width; " ... "; min + (k+1) * width; ")"
2250     NEXT k
2260   ELSE
2270     PRINT "No numbers read."
2280   END IF
2290 END IF
2300 END
2310 REM  
2320 REM Draws a bar chart from the array "values" of size nValues. 
2330 REM Turtleizer must be activated and will scale the chart into a square of 
2340 REM 500 x 500 pixels 
2350 REM Note: The function is not robust against empty array or totally equal values. 
2360 REM TODO: Add type-specific suffixes where necessary! 
2370 SUB drawBarChart(values AS array of double, nValues)
2380   REM TODO: add the respective type suffixes to your variable names if required 
2390   REM Used range of the Turtleizer screen 
2400   LET xSize = 500
2410   LET ySize = 500
2420   LET kMin = 0
2430   LET kMax = 0
2440   FOR k = 1 TO nValues-1
2450     IF values(k) > values(kMax) THEN
2460       LET kMax = k
2470     ELSE
2480       IF values(k) < values(kMin) THEN
2490         LET kMin = k
2500       END IF
2510     END IF
2520   NEXT k
2530   LET valMin = values(kMin)
2540   LET valMax = values(kMax)
2550   LET yScale = valMax * 1.0 / (ySize - 1)
2560   LET yAxis = ySize - 1
2570   IF valMin < 0 THEN
2580     IF valMax > 0 THEN
2590       LET yAxis = valMax * ySize * 1.0 / (valMax - valMin)
2600       LET yScale = (valMax - valMin) * 1.0 / (ySize - 1)
2610     ELSE
2620       LET yAxis = 1
2630       LET yScale = valMin * 1.0 / (ySize - 1)
2640     END IF
2650   END IF
2660   REM draw coordinate axes 
2670   gotoXY(1, ySize - 1)
2680   forward(ySize -1) : REM color = ffffff
2690   penUp()
2700   backward(yAxis) : REM color = ffffff
2710   right(90)
2720   penDown()
2730   forward(xSize -1) : REM color = ffffff
2740   penUp()
2750   backward(xSize-1) : REM color = ffffff
2760   LET stripeWidth = xSize / nValues
2770   FOR k = 0 TO nValues-1
2780     LET stripeHeight = values(k) * 1.0 / yScale
2790     SELECT CASE k % 3
2800       CASE 0
2810         setPenColor(255,0,0)
2820       CASE 1
2830         setPenColor(0, 255,0)
2840       CASE 2
2850         setPenColor(0, 0, 255)
2860     END SELECT
2870     fd(1) : REM color = ffffff
2880     left(90)
2890     penDown()
2900     fd(stripeHeight) : REM color = ffffff
2910     right(90)
2920     fd(stripeWidth - 1) : REM color = ffffff
2930     right(90)
2940     forward(stripeHeight) : REM color = ffffff
2950     left(90)
2960     penUp()
2970   NEXT k
2980 END SUB

REM = = = = 8< = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

