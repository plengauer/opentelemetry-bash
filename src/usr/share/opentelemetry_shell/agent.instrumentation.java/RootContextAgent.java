import java.lang.instrument.Instrumentation;
import io.opentelemetry.javaagent.shaded.io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.javaagent.shaded.io.opentelemetry.api.trace.SpanContext;
import io.opentelemetry.javaagent.shaded.io.opentelemetry.api.trace.TraceFlags;
import io.opentelemetry.javaagent.shaded.io.opentelemetry.api.trace.TraceState;
import io.opentelemetry.javaagent.shaded.io.opentelemetry.context.Context;

public class RootContextAgent {
    public static void premain(String args, Instrumentation instrumentation) {
        String traceparent = System.getenv("TRACEPARENT");
        if (traceparent == null) return;
        String[] parts = traceparent.split("-");
        Context.root().with(SpanContext.create(parts[1], parts[2], TraceFlags.fromHex(parts[3]), TraceState.getDefault())).makeCurrent();
    }
}
