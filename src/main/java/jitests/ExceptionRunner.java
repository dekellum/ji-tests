/*
 * Copyright (c) 2012 David Kellum
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License.  You may
 * obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied.  See the License for the specific language governing
 * permissions and limitations under the License.
 */

package jitests;

public class ExceptionRunner
{
    public void doItNow( final Runnable runnable )
    {
        runnable.run();
    }

    public void doItThreaded( final Runnable runnable )
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
