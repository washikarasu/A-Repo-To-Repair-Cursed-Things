import { perf } from 'common/perf';
import { render } from 'inferno';
import { createLogger } from './logging';

const logger = createLogger('renderer');

let reactRoot: any;
let initialRender: string | boolean = true;
let suspended = false;

// These functions are used purely for profiling.
export function resumeRenderer() {
  initialRender = initialRender || 'resumed';
  suspended = false;
}

export function suspendRenderer() {
  suspended = true;
}

enum Render {
  Start = 'render/start',
  Finish = 'render/finish',
}

type CreateRenderer = <T extends unknown[] = [unknown]>(
  getVNode?: (...args: T) => any,
) => (...args: T) => void;

export const createRenderer: CreateRenderer = (getVNode) => (...args) => {
  perf.mark(Render.Start);
  // Start rendering
  if (!reactRoot) {
    reactRoot = document.getElementById('react-root');
  }

  if (getVNode) {
    render(getVNode(...args), reactRoot);
  } else {
    render(args[0] as any, reactRoot);
  }

  perf.mark(Render.Finish);
  if (suspended) {
    return;
  }

  // Report rendering time
  if (process.env.NODE_ENV !== 'production') {
    if (initialRender === 'resumed') {
      logger.log('rendered in', perf.measure(Render.Start, Render.Finish));
    } else if (initialRender) {
      logger.debug('serving from:', location.href);
      logger.debug('bundle entered in', perf.measure('inception', 'init'));
      logger.debug('initialized in', perf.measure('init', Render.Start));
      logger.log('rendered in', perf.measure(Render.Start, Render.Finish));
      logger.log('fully loaded in', perf.measure('inception', Render.Finish));
    } else {
      logger.debug('rendered in', perf.measure(Render.Start, Render.Finish));
    }
  }

  if (initialRender) {
    initialRender = false;
  }
};
