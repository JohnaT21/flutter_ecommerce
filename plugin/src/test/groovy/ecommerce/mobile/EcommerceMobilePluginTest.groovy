/*
 * This Groovy source file was generated by the Gradle 'init' task.
 */
package ecommerce.mobile

import org.gradle.testfixtures.ProjectBuilder
import org.gradle.api.Project
import spock.lang.Specification

/**
 * A simple unit test for the 'ecommerce.mobile.greeting' plugin.
 */
class EcommerceMobilePluginTest extends Specification {
    def "plugin registers task"() {
        given:
        def project = ProjectBuilder.builder().build()

        when:
        project.plugins.apply("ecommerce.mobile.greeting")

        then:
        project.tasks.findByName("greeting") != null
    }
}