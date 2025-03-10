import java.lang.instrument.Instrumentation;
import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.trace.SpanContext;
import io.opentelemetry.api.trace.TraceFlags;
import io.opentelemetry.api.trace.TraceState;
import io.opentelemetry.context.Context;

public class Agent {
    public static void premain(String args, Instrumentation instrumentation) {
        String traceparent = System.getenv("TRACEPARENT");
        if (traceparent == null) return;
        String[] parts = traceparent.split("-");
        Context.root().with(SpanContext.create(parts[1], parts[2], TraceFlags.fromHex(parts[3]), TraceState.getDefault())).makeCurrent();
    }
}
