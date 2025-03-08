package com.example;

import org.springframework.util.StopWatch;

import java.time.Clock;
import java.time.Duration;

public class Stopwatch {
    private static void mockTask() {
        // Some task goes here
    }

    public static Duration naive() {
        var clock = Clock.systemUTC();
        var start = clock.instant();
        mockTask();
        var end = clock.instant();
        return Duration.between(start, end);
    }

    public static long spring() {
        var stopwatch = new StopWatch();
        stopwatch.start();
        mockTask();
        stopwatch.stop();
        return stopwatch.getTotalTimeMillis();
    }

    public static void main(final String args[]) {
        var elapsed = naive();
        var elapsed2 = spring();
        System.out.println(elapsed.toString());
        System.out.println(elapsed2);
    }
}