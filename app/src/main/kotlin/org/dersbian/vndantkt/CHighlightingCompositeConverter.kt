package org.dersbian.vndantkt

import ch.qos.logback.classic.Level
import ch.qos.logback.classic.spi.ILoggingEvent
import ch.qos.logback.core.pattern.color.ForegroundCompositeConverterBase

import ch.qos.logback.core.pattern.color.ANSIConstants.*

class CHighlightingCompositeConverter : ForegroundCompositeConverterBase<ILoggingEvent>() {

    override fun getForegroundColorCode(event: ILoggingEvent): String {
        val level = event.level
        return when (level.toInt()) {
            Level.ERROR_INT -> "$BOLD$RED_FG"
            Level.WARN_INT -> YELLOW_FG
            Level.INFO_INT -> BLUE_FG
            Level.DEBUG_INT -> GREEN_FG
            else -> DEFAULT_FG
        }
    }
}
