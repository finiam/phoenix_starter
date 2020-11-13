import React, { forwardRef, lazy, Suspense } from "react";

export default function asyncImporter(importStatement, fallback = "") {
  const LazyComponent = lazy(() => importStatement);
  const Component = forwardRef((props, ref) => (
    <Suspense fallback={fallback}>
      <LazyComponent {...props} ref={ref} />
    </Suspense>
  ));

  LazyComponent.preload = importStatement;

  return Component;
}
