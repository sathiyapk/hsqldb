/* Copyright (c) 2001-2009, The HSQL Development Group
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * Neither the name of the HSQL Development Group nor the names of its
 * contributors may be used to endorse or promote products derived from this
 * software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL HSQL DEVELOPMENT GROUP, HSQLDB.ORG,
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


package org.hsqldb.cmdline;

import org.hsqldb.lib.ValidatingResourceBundle;
import org.hsqldb.lib.RefCapablePropertyResourceBundle;

public class SqltoolRBTest extends junit.framework.TestCase {
    private SqltoolRB rb1 = null;
    private SqltoolRB rb2 = null;
    private static final String[] testParams = {"one", "two", "three", "four"};

    public void setUp() {
        rb1 = new SqltoolRB();
        rb2 = new SqltoolRB();
    }

    static private final String RAW_CONN_MSG =
        "JDBC Connection established to a %{1} v. %{2} database\n"
        + "as \"%{3}\" with %{4} Isolation.";
    static private final String SUBSTITUTED_CONN_MSG =
        ("JDBC Connection established to a %{1} v. %{2} database\n"
        + "as \"%{3}\" with %{4} Isolation.")
        .replaceAll("\\Q%{1}", testParams[0])
        .replaceAll("\\Q%{2}", testParams[1])
        .replaceAll("\\Q%{3}", testParams[2])
        .replaceAll("\\Q%{4}", testParams[3]);

    /**
     * No positional parameters set...
     */
    public void testNoPosParams() {
        try {
            rb1.validate();
            rb2.validate();
            //System.err.println("rb1 size = " + rb1.getSize());
            //System.err.println("rb2 size = " + rb2.getSize());
            rb1.setMissingPosValueBehavior(
                ValidatingResourceBundle.EMPTYSTRING_BEHAVIOR);
            rb2.setMissingPosValueBehavior(
                ValidatingResourceBundle.NOOP_BEHAVIOR);

            /*
            rb1.setMissingPropertyBehavior(
                    ValidatingResourceBundle.THROW_BEHAVIOR);
            System.out.println("("
                    + rb1.getExpandedString(SqltoolRB.JDBC_ESTABLISHED) + ')');
            */

            // When no substitution parameter at all given to getString(), behavior
            // settings have no influence, and no subsitution is performed.
            assertEquals(RAW_CONN_MSG, rb1.getString(SqltoolRB.JDBC_ESTABLISHED));
            assertEquals(RAW_CONN_MSG, rb2.getString(SqltoolRB.JDBC_ESTABLISHED));

            assertEquals(RAW_CONN_MSG.replaceAll("%\\{\\d+\\}", ""),
                    rb1.getString(SqltoolRB.JDBC_ESTABLISHED, new String[] {}));
            assertEquals(RAW_CONN_MSG,
                rb2.getString(SqltoolRB.JDBC_ESTABLISHED, new String[] {}));
        } catch (Exception e) {
            fail ("RB system choked w/ " + e);
        }

        try {
            rb1.setMissingPosValueBehavior(
                 RefCapablePropertyResourceBundle.THROW_BEHAVIOR);
            rb1.getString(SqltoolRB.JDBC_ESTABLISHED, new String[] {});
        } catch (RuntimeException ee) {
            return;  // Unsatisfied %{} should cause throw here
        } catch (Exception e) {
            fail ("RB system choked w/ " + e);
        }
    }

    /**
     * With positional params set to one/two/three
     */
    public void testWithParams() {
        try {
            rb1.validate();
            rb2.validate();
            rb1.setMissingPosValueBehavior(
                    ValidatingResourceBundle.EMPTYSTRING_BEHAVIOR);
            rb2.setMissingPosValueBehavior(
                ValidatingResourceBundle.NOOP_BEHAVIOR);
            assertEquals(SUBSTITUTED_CONN_MSG,
                    rb1.getString(SqltoolRB.JDBC_ESTABLISHED, testParams));
            assertEquals(SUBSTITUTED_CONN_MSG,
                    rb2.getString(SqltoolRB.JDBC_ESTABLISHED, testParams));
            rb1.setMissingPosValueBehavior(
                 RefCapablePropertyResourceBundle.THROW_BEHAVIOR);
            assertEquals(SUBSTITUTED_CONN_MSG,
                    rb1.getString(SqltoolRB.JDBC_ESTABLISHED, testParams));
        } catch (Exception e) {
            fail ("RB system choked w/ " + e);
        }
    }

    /**
     * This method allows to easily run this unit test independent of the other
     * unit tests, and without dealing with Ant or unrelated test suites.
     */
    static public void main(String[] sa) {
        if (sa.length > 0 && sa[0].startsWith("-g")) {
            junit.swingui.TestRunner.run(SqltoolRBTest.class);
        } else {
            junit.textui.TestRunner runner = new junit.textui.TestRunner();
            junit.framework.TestResult result =
                runner.run(runner.getTest(SqltoolRBTest.class.getName()));

            System.exit(result.wasSuccessful() ? 0 : 1);
        }
    }
}
