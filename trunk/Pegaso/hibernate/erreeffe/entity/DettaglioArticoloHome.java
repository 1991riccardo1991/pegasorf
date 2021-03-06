package erreeffe.entity;
// Generated 19-nov-2008 20.32.15 by Hibernate Tools 3.2.2.GA


import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import static org.hibernate.criterion.Example.create;

/**
 * Home object for domain model class DettaglioArticolo.
 * @see erreeffe.entity.DettaglioArticolo
 * @author Hibernate Tools
 */
public class DettaglioArticoloHome {

    private static final Log log = LogFactory.getLog(DettaglioArticoloHome.class);

    private final SessionFactory sessionFactory = getSessionFactory();
    
    protected SessionFactory getSessionFactory() {
        try {
            return (SessionFactory) new InitialContext().lookup("SessionFactory");
        }
        catch (Exception e) {
            log.error("Could not locate SessionFactory in JNDI", e);
            throw new IllegalStateException("Could not locate SessionFactory in JNDI");
        }
    }
    
    public void persist(DettaglioArticolo transientInstance) {
        log.debug("persisting DettaglioArticolo instance");
        try {
            sessionFactory.getCurrentSession().persist(transientInstance);
            log.debug("persist successful");
        }
        catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }
    
    public void attachDirty(DettaglioArticolo instance) {
        log.debug("attaching dirty DettaglioArticolo instance");
        try {
            sessionFactory.getCurrentSession().saveOrUpdate(instance);
            log.debug("attach successful");
        }
        catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
    
    public void attachClean(DettaglioArticolo instance) {
        log.debug("attaching clean DettaglioArticolo instance");
        try {
            sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        }
        catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
    
    public void delete(DettaglioArticolo persistentInstance) {
        log.debug("deleting DettaglioArticolo instance");
        try {
            sessionFactory.getCurrentSession().delete(persistentInstance);
            log.debug("delete successful");
        }
        catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }
    
    public DettaglioArticolo merge(DettaglioArticolo detachedInstance) {
        log.debug("merging DettaglioArticolo instance");
        try {
            DettaglioArticolo result = (DettaglioArticolo) sessionFactory.getCurrentSession()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        }
        catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }
    
    public DettaglioArticolo findById( long id) {
        log.debug("getting DettaglioArticolo instance with id: " + id);
        try {
            DettaglioArticolo instance = (DettaglioArticolo) sessionFactory.getCurrentSession()
                    .get("erreeffe.entity.DettaglioArticolo", id);
            if (instance==null) {
                log.debug("get successful, no instance found");
            }
            else {
                log.debug("get successful, instance found");
            }
            return instance;
        }
        catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
    
    public List<DettaglioArticolo> findByExample(DettaglioArticolo instance) {
        log.debug("finding DettaglioArticolo instance by example");
        try {
            List<DettaglioArticolo> results = (List<DettaglioArticolo>) sessionFactory.getCurrentSession()
                    .createCriteria("erreeffe.entity.DettaglioArticolo")
                    .add( create(instance) )
            .list();
            log.debug("find by example successful, result size: " + results.size());
            return results;
        }
        catch (RuntimeException re) {
            log.error("find by example failed", re);
            throw re;
        }
    } 
}

