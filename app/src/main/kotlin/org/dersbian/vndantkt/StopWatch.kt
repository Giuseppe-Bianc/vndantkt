package org.dersbian.vndantkt

import org.slf4j.Logger
import org.slf4j.LoggerFactory

import java.time.Duration
import java.time.Instant

class StopWatch(private val name: String) {
    private val log: Logger = LoggerFactory.getLogger(StopWatch::class.java)
    private final val TIME_FACTOR = 1_000L
    private final val TIME_FACTOR2 = 1_000_000_000L
    private final val TIME_FACTOR3 = 1_000_000L
    private final val TIME_FACTOR4 = 60L
    private var startTime: Instant? = null
    private var elapsedTime: Duration = Duration.ZERO
    private var running = false

    @Synchronized
    fun start() {
        if (!running) {
            startTime = Instant.now()
            running = true
        } else {
            log.warn("Stopwatch '$name' is already running.")
        }
    }

    @Synchronized
    fun stop() {
        if (running) {
            elapsedTime = elapsedTime.plus(Duration.between(startTime, Instant.now()))
            running = false
            displayTime()
            elapsedTime = Duration.ZERO
        } else {
            log.warn("Stopwatch '$name' is not running.")
        }
    }

    /*fun reset() {
        elapsedTime = Duration.ZERO
        running = false
        log.info("Stopwatch '$name' reset.")
    }*/

    private fun displayTime() {
        val totalNanos = elapsedTime.toNanos()

        val totalSeconds = totalNanos / TIME_FACTOR2
        val totalMilliseconds = totalNanos / TIME_FACTOR3
        val totalMicroseconds = totalNanos / TIME_FACTOR

        val minutes = totalSeconds / TIME_FACTOR4
        val seconds = totalSeconds % TIME_FACTOR4
        val milliseconds = totalMilliseconds % TIME_FACTOR
        val microseconds = totalMicroseconds % TIME_FACTOR
        val nanoseconds = totalNanos % TIME_FACTOR

        if (minutes > 0) {
            log.info("$name Tempo trascorso: $minutes m, $seconds s, $milliseconds ms, $microseconds us, $nanoseconds ns")
        } else {
            log.info("$name Tempo trascorso: $seconds s, $milliseconds ms, $microseconds us, $nanoseconds ns")
        }
    }
}