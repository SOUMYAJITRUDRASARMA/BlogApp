package com.soumyajit.blog_on.security;

import static org.springframework.security.config.Customizer.withDefaults;

import org.apache.tomcat.util.net.DispatchType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.method.configuration.GlobalMethodSecurityConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.security.web.server.authentication.logout.DelegatingServerLogoutHandler;
import org.springframework.security.web.server.authentication.logout.SecurityContextServerLogoutHandler;
import org.springframework.security.web.server.authentication.logout.WebSessionServerLogoutHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.RequestDispatcher;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SpringSecurityConfig extends GlobalMethodSecurityConfiguration {
    
    @Autowired
    private UserAuthenticator userAuthenticator;
    @Autowired
    private Environment environment;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return NoOpPasswordEncoder.getInstance();
        // return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity httpSecurity) throws Exception {
        AuthenticationManagerBuilder authenticationManagerBuilder = httpSecurity.getSharedObject(AuthenticationManagerBuilder.class);
        authenticationManagerBuilder.userDetailsService(userAuthenticator).passwordEncoder(passwordEncoder());
        return authenticationManagerBuilder.build();
    }

    // @Bean
    // @Order(1)
    // public SecurityFilterChain securityFilterChain1(HttpSecurity httpSecurity) throws Exception {
    //     return httpSecurity.authorizeHttpRequests(auth -> auth.requestMatchers("/admin/dashboard").authenticated())
    //     .formLogin().loginPage("/admin/login").defaultSuccessUrl("/admin/dashboard").and()
    //     .logout().logoutUrl("/logout").logoutSuccessUrl("/home").deleteCookies("JSESSIONID").invalidateHttpSession(true).clearAuthentication(true).and()
    //     .headers().cacheControl().disable().and()
    //     .csrf().disable()
    //     .build();
    // }

    // @Bean
    // @Order(2)
    // public SecurityFilterChain securityFilterChain2(HttpSecurity httpSecurity) throws Exception {
    //     return httpSecurity.authorizeHttpRequests(auth -> auth.requestMatchers("/creator/dashboard").authenticated())
    //     .formLogin().loginPage("/creator/login").defaultSuccessUrl("/creator/dashboard").and()
    //     .logout().logoutUrl("/logout").logoutSuccessUrl("/home").deleteCookies("JSESSIONID").invalidateHttpSession(true).clearAuthentication(true).and()
    //     .headers().cacheControl().disable().and()
    //     .csrf().disable()
    //     .build();
    // }

    @Bean
    // @Order(3)
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        return httpSecurity.authorizeHttpRequests(
            authorize -> authorize
                .requestMatchers(HttpMethod.GET, "/admin/dashboard",  "/creator/dashboard").authenticated()
                .anyRequest().permitAll()

                // .requestMatchers(HttpMethod.OPTIONS, "/**").permitAll()
                // .requestMatchers(HttpMethod.GET, "/home", "/creator/login", "/creator/signup", "/admin/login", "/admin/signup", "/logout", "/session/**").permitAll()
                // .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()  // allowes unrestricted access for forwarded requests (to allow JSPs to be forwarded) ...
                // .anyRequest().authenticated()

                // .and()
                // .formLogin().loginPage("/login").successHandler((req, res, auth) -> {
                //     String role = auth.getAuthorities().iterator().next().getAuthority();
                //     String loginPage = environment.getProperty("login.pages." + role.toLowerCase());
                //     res.sendRedirect(req.getContextPath() + loginPage);
                // })
        )
        .logout().logoutSuccessUrl("/home").deleteCookies("JSESSIONID").invalidateHttpSession(true).clearAuthentication(true).and()
        // .logout().logoutSuccessUrl("/home").deleteCookies("JSESSIONID").invalidateHttpSession(true).clearAuthentication(true).and()
        // .formLogin().loginPage("/login").loginProcessingUrl("/login").defaultSuccessUrl("/creator/dashboard")
        // .failureHandler((req, res, authExc) -> {
        //     req.setAttribute("result", true);
        //     // Set method to Http GET ...
        //     // RequestDispatcher requestDispatcher = req.getRequestDispatcher("/login");
        //     RequestDispatcher requestDispatcher = req.getRequestDispatcher("/login_error");
        //     requestDispatcher.forward(req, res);
        // })
        // .and()
        .formLogin().loginPage("/login").loginProcessingUrl("/login").successHandler((req, res, auth) -> {
            String role = auth.getAuthorities().iterator().next().getAuthority();
            String destUrl;
            if(role.equals("ROLE_ADMIN")) destUrl = "/admin/dashboard";
            else if(role.equals("ROLE_CREATOR")) destUrl = "/creator/dashboard";
            else destUrl = "/access_denied";
            res.sendRedirect(destUrl);
        }).failureUrl("/login?error=true").and()
        // .formLogin().loginPage("/login").loginProcessingUrl("/login").successHandler((req, res, auth) -> {
        //     String role = auth.getAuthorities().iterator().next().getAuthority();
        //     String destUrl;
        //     if(role.equals("ROLE_ADMIN")) destUrl = "/admin/dashboard";
        //     else if(role.equals("ROLE_CREATOR")) destUrl = "/creator/dashboard";
        //     else destUrl = "/access_denied";
        //     res.sendRedirect(destUrl);
        // }).failureUrl("/login?error=true").and()
        // .formLogin().loginPage("/login").loginProcessingUrl("/login").defaultSuccessUrl("/creator/dashboard").failureUrl("/login?error=true").and()
        // .formLogin().loginPage("/creator/login").loginProcessingUrl("/creator/login").defaultSuccessUrl("/creator/dashboard").and()
        // .formLogin().loginPage("/admin/login").loginProcessingUrl("/admin/login").defaultSuccessUrl("/admin/dashboard").and()
        .exceptionHandling().accessDeniedPage("/access_denied").and()
        // .httpBasic(withDefaults())
        // .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED).maximumSessions(1).expiredUrl("/session/expired").and().and()
        // .headers().cacheControl().disable().and()
        .csrf().disable()
        .build();

        // httpSecurity.authorizeHttpRequests().anyRequest().hasRole("ROLE_ADMIN").and().formLogin().loginPage("/admin/login").loginProcessingUrl("/admin/login").defaultSuccessUrl("/admin/dashboard").permitAll();

        // httpSecurity.authorizeHttpRequests().anyRequest().hasRole("ROLE_CREATOR").and().formLogin().loginPage("/creator/login").loginProcessingUrl("/creator/login").defaultSuccessUrl("/creator/dashboard").permitAll();

        // return httpSecurity.authorizeHttpRequests(
        //     authorize -> {
        //         try {
        //             authorize
        //                 // .requestMatchers(new AntPathRequestMatcher("/**", "OPTIONS")).permitAll()
        //                 // .requestMatchers(new AntPathRequestMatcher("/home", "GET")).permitAll()
        //                 // .requestMatchers(new AntPathRequestMatcher("/webapp_res/**", "GET")).permitAll()
        //                 // .requestMatchers(new AntPathRequestMatcher("/css/**", "GET")).permitAll()
        //                 // .requestMatchers(new AntPathRequestMatcher("/js/**", "GET")).permitAll()
        //                 // .requestMatchers(HttpMethod.GET, "/home", "/index").permitAll()

        //                 // .requestMatchers(HttpMethod.OPTIONS, "/**").permitAll()
        //                 // .requestMatchers("/home", "/creator/login", "/creator/signup", "/admin/login", "/admin/signup").permitAll()
        //                 // .requestMatchers("/test/t1").permitAll()  // Testing ...
        //                 // .requestMatchers(HttpMethod.GET, "/webapp_res/**", "/css/**", "/js/**").permitAll()
        //                 // .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()  // allowes unrestricted access for forwarded requests (to allow JSPs to be forwarded) ...
        //                 // .anyRequest().authenticated()

        //                 .requestMatchers(HttpMethod.GET, "/admin/dashboard",  "/creator/dashboard").authenticated()
        //                 .anyRequest().permitAll()
        //                 .and()
        //                 .formLogin().loginPage("/login").successHandler((req, res, auth) -> {
        //                     String role = auth.getAuthorities().iterator().next().getAuthority();
        //                     String loginPage = environment.getProperty("login.pages." + role.toLowerCase());
        //                     res.sendRedirect(req.getContextPath() + loginPage);
        //                 });
        //         } catch(Exception e){ e.printStackTrace(); }
        //     }
        // )
        // .httpBasic(withDefaults())
        // .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED))
        // .csrf().disable()
        // .build();
    }

}
