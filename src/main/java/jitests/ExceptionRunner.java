package jitests;

public class ExceptionRunner
{
    public void doIt( final Runnable runnable )
        throws InterruptedException
    {
        Wrapper w = new Wrapper( runnable );
        Thread t = new Thread( w );
        t.start();
        t.join();
        if(  w.caught != null ) {
            throw w.caught;
        }
    }

    class Wrapper implements Runnable
    {
        Wrapper( Runnable runnable )
        {
            _runnable = runnable;
        }

        public void run()
        {
            try {
                _runnable.run();
            }
            catch( RuntimeException x ) {
                caught = x;
            }
        }
        public RuntimeException caught = null;

        private Runnable _runnable = null;
    }

}