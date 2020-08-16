package com.profteam.bookgarden.service;

import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.zalando.problem.DefaultProblem;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.profteam.bookgarden.dto.ResponseDto;

@Component
@Transactional(rollbackFor = Throwable.class)
public class LoggingService {

    private static final Logger LOG = LoggerFactory.getLogger(LoggingService.class);

    /**
     * Log request.
     *
     * @param httpServletRequest the http servlet request
     * @param body the body
     */
    public void logRequest(HttpServletRequest httpServletRequest, Object body) {

        try {
            StringBuilder stringBuilder = new StringBuilder();
            Map<String, String> parameters = buildParametersMap(httpServletRequest);

            stringBuilder.append("REQUEST ");
            stringBuilder.append("method=[").append(httpServletRequest.getMethod()).append("] ");
            stringBuilder.append("path=[").append(httpServletRequest.getRequestURI()).append("] ");

            if (!parameters.isEmpty()) {
                stringBuilder.append("parameters=[").append(parameters).append("] ");
            }

            if (body != null) {
                ObjectMapper mapper = new ObjectMapper();
                stringBuilder.append("body=[" + mapper.writeValueAsString(body) + "]");
            }

            LOG.info(stringBuilder.toString());
        } catch (Exception e) {
            LOG.error(e.getMessage());
        }

    }

    /**
     * Log response.
     *
     * @param httpServletRequest the http servlet request
     * @param httpServletResponse the http servlet response
     * @param body the body
     */
    public void logResponse(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
        Object body) {
        try {
            StringBuilder stringBuilder = new StringBuilder();
            ObjectMapper mapper = new ObjectMapper();
            ResponseDto response = getResponse(body);
            
            stringBuilder.append("RESPONSE ");
            stringBuilder.append("method=[").append(httpServletRequest.getMethod()).append("] ");
            stringBuilder.append("path=[").append(httpServletRequest.getRequestURI()).append("] ");
            stringBuilder.append("responseHeaders=[").append(buildHeadersMap(httpServletResponse)).append("] ");
            stringBuilder.append("responseBody=[").append(mapper.writeValueAsString(response)).append("] ");

            LOG.info(stringBuilder.toString());
        } catch (Exception e) {
            LOG.error(e.getMessage());
        }

    }

    /**
     * Builds the parameters map.
     *
     * @param httpServletRequest the http servlet request
     * @return the map
     */
    private Map<String, String> buildParametersMap(HttpServletRequest httpServletRequest) {
        Map<String, String> resultMap = new HashMap<>();
        Enumeration<String> parameterNames = httpServletRequest.getParameterNames();

        while (parameterNames.hasMoreElements()) {
            String key = parameterNames.nextElement();
            String value = httpServletRequest.getParameter(key);
            resultMap.put(key, value);
        }

        return resultMap;
    }

    /**
     * Builds the headers map.
     *
     * @param response the response
     * @return the map
     */
    private Map<String, String> buildHeadersMap(HttpServletResponse response) {
        Map<String, String> map = new HashMap<>();

        Collection<String> headerNames = response.getHeaderNames();
        for (String header : headerNames) {
            map.put(header, response.getHeader(header));
        }

        return map;
    }

    /**
     * Gets the response.
     *
     * @param obj the obj
     * @return the response
     */
    @SuppressWarnings("unchecked")
    private ResponseDto getResponse(Object obj) {

        Map<String, Object> mapRes = null;
        ResponseDto res = new ResponseDto();

        if (obj instanceof HashMap) {
            mapRes = (Map<String, Object>) obj;
        } else if (obj instanceof DefaultProblem) {
            DefaultProblem problem = (DefaultProblem) obj;
            mapRes = problem.getParameters();
        } else {
            mapRes = new HashMap<>();
        }

        if (mapRes.size() > 0) {
            for (Map.Entry<String, Object> entry : mapRes.entrySet()) {
                res = (ResponseDto) entry.getValue();
            }
        }

        return res;
    }
}
