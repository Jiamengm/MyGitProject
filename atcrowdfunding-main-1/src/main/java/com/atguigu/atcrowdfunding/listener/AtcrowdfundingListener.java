package com.atguigu.atcrowdfunding.listener;

import com.atguigu.atcrowdfunding.util.Const;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class AtcrowdfundingListener implements ServletContextListener {
    Logger logger = LoggerFactory.getLogger(AtcrowdfundingListener.class);
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {

        ServletContext applicationContext = servletContextEvent.getServletContext();
        String contextPath = applicationContext.getContextPath();
        applicationContext.setAttribute(Const.PATH,contextPath);
        logger.info("AtcrowdfundingListener - contextInitialized 将["+contextPath+"]存放到application域");
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        logger.info("AtcrowdfundingListener - contextDestroyed 开始销毁了");
    }
}
